#
# Title: Report ZIP File Validation
# 
# Description: Given a report ZIP file that we're trying to install, run a series of validation tests to see if we can preemptively identify a failing ZIP.
#
# Parameters: 
#   $ReportZipPath - string; required; represents a valid file path to an EnergyCAP report installation ZIP file
#

param(    
    [Parameter(Mandatory=$true)]
    [string]$ReportZipPath
)

# Global Variables
$globalFailures = 0
$globalPasses = 0

# Dependencies
Add-Type -AssemblyName System.IO.Compression.FileSystem
[reflection.assembly]::LoadWithPartialName('CrystalDecisions.Shared')
[reflection.assembly]::LoadWithPartialName('CrystalDecisions.CrystalReports.Engine')

# Functions
function Fail($message) {
    Write-Host "FAIL: $message" -ForegroundColor Red
    $globalFailures++
}

function Pass($message) {
    Write-Host "PASS: $message" -ForegroundColor Green    
    $globalPasses++
}

function Out($message)
{
    Write-Host $message
}

function lint-json([string] $filePath) {
    # source: https://stackoverflow.com/questions/17034954/how-to-check-if-file-has-valid-json-syntax-in-powershell    
    try {
        $fileContents = [IO.File]::ReadAllText($filePath)
        $obj = ConvertFrom-Json $fileContents -ErrorAction Stop
        $validJson = $true
    }
    catch {
        $validJson = $false
    }

    if(-not $validJson) {
        Write-Host "$filePath is not a valid JSON file!" -ForegroundColor Red
    }
}
# EXAMPLE 1: Lint all the JSON files in a folder
# Get-ChildItem *.json | Select-Object -Property fullname | ForEach-Object { lint-json $_.FullName }

# Tests

function Run-Tests() {
    Test-Contains-BeginSQL
    Test-BeginSQL-OpensTransaction
    Test-Contains-EndSQL
    Test-EndSQL-ClosesTransaction
    Test-Zip-ContainsAtLeast1JsonFile
    Test-Lint-AllJsonFiles
    Test-AllReports-AllHaveJsonAndRptRdlAndSql
    Test-CrystalReports-AllHaveECEVersion    
    Test-Report-AllHaveImageFiles
    Test-SSRS-Report-URLS
    #Test-CrystalReportVersions-Vs-JsonVersions
}

#
# If begin.sql does not exist, the report install API will fail. This is a required file.
#
function Test-Contains-BeginSQL()
{
    if([IO.File]::Exists("$workingFolder\begin.sql") -eq $false) {
        Fail("ZIP does not contain begin.sql file")
    }
    else {
        Pass("ZIP contains begin.sql file")
    }    
}

#
# If begin.sql does not open a transaction, the report install may get into a half-state where records were inserted into the Report table but no SpecificReports were inserted.
#
function Test-BeginSQL-OpensTransaction()
{
    if(-not [IO.File]::Exists("$workingFolder\begin.sql"))
    {
        # can't test if begin.sql doesn't exist
        return
    }

    [string]$beginSql = [IO.File]::ReadAllText("$workingFolder\begin.sql")
    $transactionSyntax = "BEGIN TRANSACTION"
    if($beginSql.Contains($transactionSyntax) -eq $false) {
        Fail("begin.sql file does not open transaction")
    }
    else {
        Pass("begin.sql opens transaction")
    }
}

#
# If end.sql does not exist, the report install API will fail. This is a required file.
#
function Test-Contains-EndSQL()
{
    if([IO.File]::Exists("$workingFolder\end.sql") -eq $false) {
        Fail("ZIP does not contain end.sql file")
    }
    else {
        Pass("ZIP contains end.sql file")
    }
}

#
# If begin.sql does not close a transaction, the report install may get into a half-state where the installation was successful but never committed.
#
function Test-EndSQL-ClosesTransaction()
{
    if(-not [IO.File]::Exists("$workingFolder\end.sql"))
    {
        # can't test if end.sql doesn't exist
        return
    }

    [string]$endSql = [IO.File]::ReadAllText("$workingFolder\end.sql")
    $transactionSyntax = "COMMIT TRANSACTION"
    if($endSql.Contains($transactionSyntax) -eq $false) {
        Fail("end.sql file does not close transaction")
    }
    else {
        Pass("end.sql closes transaction")
    }
}

#
# If there are no JSON files, the report installer will not do any work
#
function Test-Zip-ContainsAtLeast1JsonFile()
{
    $jsonFiles = [IO.Directory]::GetFiles("$workingFolder", "*.json")
    $jsonFileCount = $jsonFiles.Length
    if($jsonFileCount -eq 0) {
        Fail("There must be at least 1 JSON file in the report install ZIP")
    }
    else {
        Pass("ZIP contains $jsonFileCount JSON files")
    }
}

#
# If the JSON files fail linting (e.g. because of a missing comma, bad quotes, etc.) then the report installation will fail
#
function Test-Lint-AllJsonFiles()
{
    $jsonFiles = [IO.Directory]::GetFiles("$workingFolder", "*.json")
    $successCount = 0
    $failCount = 0

    if($jsonFiles.Count -eq 0)
    {
        # can't lint files if there aren't any
        return;
    }

    foreach($jsonFile in $jsonFiles) {
        $jsonIsValid = (lint-json -filePath $jsonFile)
        if($jsonIsValid -eq $false) {
            $fileName = [IO.Path]::GetFileName($jsonFile)
            Fail("$fileName is not a valid JSON file")
            $failCount++
        }
        else {
            $successCount++
        }
    }

    if($failCount -ne 0) {
        Fail("$failCount JSON files failed validation")
    }
    else {
        Pass("$successCount JSON files passed validation")
    }
}

#
# If a report doesn't have an accompanying SQL file named {reportCode}.sql or RPT/RDL file named according to the value in {reportName}, the install or report execution will fail
#
function Test-AllReports-AllHaveJsonAndRptRdlAndSql()
{
    $jsonFiles = [IO.Directory]::GetFiles("$workingFolder", "*.json")
    $successCount = 0
    $failCount = 0
    
    foreach($jsonFile in $jsonFiles) {
        $jsonFileContents = [IO.File]::ReadAllText($jsonFile)
        $reportDefinition = ConvertFrom-Json $jsonFileContents                
        $ext = ([IO.Path]::GetExtension($reportDefinition.reportName)).ToUpper()

        # expect there to be an RPT or RDL file named according to the reportName
        if([IO.File]::Exists("$workingFolder\$($reportDefinition.reportName)") -eq $false) {
            Fail("$($reportDefinition.reportCode) missing its $ext file")
            $failCount++
        }

        # expect there to be a SQL file named according to the reportCode
        if([IO.File]::Exists("$workingFolder\$($reportDefinition.reportCode).sql") -eq $false) {
            Fail("$($reportDefinition.reportCode) missing its SQL file")
            $failCount
        }        
    }

    if($failCount -ne 0) {
        Fail("$failCount validation errors related to missing SQL or RPT files")
    }
    else {
        Pass("All reports have correctly-named JSON, RPT, and SQL files")
    }
}

#
# If a Crystal Report is not saved in the legacy format within the \installedClient subfolder, then it will cause errors when executing the report in the installed client (b/c it won't be picked up by ITSS's automated report install process)
#
function Test-CrystalReports-AllHaveECEVersion()
{
    $jsonFiles = [IO.Directory]::GetFiles("$workingFolder", "*.json")
    $successCount = 0
    $failCount = 0
    
    foreach($jsonFile in $jsonFiles) {
        $jsonFileContents = [IO.File]::ReadAllText($jsonFile)
        $reportDefinition = ConvertFrom-Json $jsonFileContents
                
        if($reportDefinition.reportName.ToLower().Contains(".rpt")) {
            # expect there to be an RPT file in the \installedClient subfolder named according to the reportName
            if([IO.File]::Exists("$workingFolder\installedClient\$($reportDefinition.reportName)") -eq $false) {
                Fail("$($reportDefinition.reportCode) missing its legacy version")
                $failCount++
            }
        }
    }

    if($failCount -ne 0) {
        Fail("$failCount validation errors related to missing legacy versions of RPT files")
    }
    else {
        Pass("All Crystal Reports have corresponding legacy versions of RPT files")
    }
}

function Test-Report-AllHaveImageFiles()
{
    $jsonFiles = [IO.Directory]::GetFiles("$workingFolder", "*.json")
    $successCount = 0
    $failCount = 0
    
    foreach($jsonFile in $jsonFiles) {
        $jsonFileContents = [IO.File]::ReadAllText($jsonFile)
        $reportDefinition = ConvertFrom-Json $jsonFileContents
        
        # expect there to be a JPG file in the \images subfolder named according to the reportCode
        # exclude System SSRS reports from this check (e.g. System-01, System-02); they will never have preview images
        if($reportDefinition.reportName.ToLower().Contains("system-") -eq $false -and [IO.File]::Exists("$workingFolder\images\$($reportDefinition.reportCode).jpg") -eq $false) {
            Fail("$($reportDefinition.reportCode) missing its report image")
            $failCount++
        }        
    }

    if($failCount -ne 0) {
        Fail("$failCount reports are missing their report image files")
    }
    else {
        Pass("All reports have their image files")
    }
}

function Test-SSRS-Report-URLS()
{
    $rdls = [io.directory]::GetFiles("$workingFolder", "*.rdl", [io.searchoption]::AllDirectories)

    # Any reports that have URL parameters that aren't in this list will fail to provide the correct links from generated reports back to EnergyCAP 7; the placeholder
    # in the RDL file will be used instead, and it may be a testing value such as http://test.energycap.com, which isn't a real instance of the app. EnergyCAP 7
    # provides the correct hyperlinks when the SSRS reports are rendered via ReportParameterService.

    # Source for the array below: ReportParameterService.cs in EnergyCAP 7 cf. line 47
    $supportedUrlParameters = (
        "accountURL", 
        "vendorURL", 
        "billURL",
        "meterURL", 
        "buildingURL", 
        "organizationURL", 
        "commodityURL", 
        "costCenterURL"
    )

    $failCount = 0
    foreach($rdl in $rdls)
    {
        [xml]$contents = [io.file]::ReadAllText($rdl)
        $contents.Report.ReportParameters.ReportParameter | ForEach-Object {            
            if(-not [string]::IsNullOrWhiteSpace($_.Name) -and $_.name.ToUpper().Contains("URL") -and -not $supportedUrlParameters.Contains($_.Name))
            {
                $failMsg = [io.path]::GetFileName($rdl) + " uses an unsupported URL report parameter: " + $_.Name
                Fail($failMsg)
                $failCount++
            }
        }
    }

    if($failCount -ne 0) {
        Fail("$failCount reports contain unsupported URL report parameters")
    }
    else {
        Pass("All reports use supported URL report parameters")
    }
}

function Test-CrystalReportVersions-Vs-JsonVersions()
{
    $jsonFiles = [IO.Directory]::GetFiles("$workingFolder", "*.json")
    $successCount = 0
    $failCount = 0
    
    foreach($jsonFile in $jsonFiles) {        

        $jsonFileContents = [IO.File]::ReadAllText($jsonFile)
        $reportDefinition = ConvertFrom-Json $jsonFileContents
        
        # Only process Crystal Report files
        if($reportDefinition.reportName.ToLower().Contains(".rpt" -eq $false)){
            continue
        }

        # Test the 2008 Crystal Report. Expect the version number in the *.RPT file to match the version number in the JSON definition file.
        $report = New-Object CrystalDecisions.CrystalReports.Engine.ReportDocument
        $CR2008ReportPath = "$workingFolder\" + $reportDefinition.reportName
        
        try{
            $report.Load($CR2008ReportPath)
        }catch{
            Fail("Unable to load RPT file $CR2008ReportPath")
            continue
        }        
        
        $cr2008Version = $report.DataDefinition.FormulaFields["ESReportVersion"].Text
        
        if($reportDefinition.version -ne $cr2008Version) {
            Fail("$($reportDefinition.reportCode) JSON version $($reportDefinition.version) does not match the Crystal 2008 file's version $($cr2008Version)")
            $failCount++
        }        

        # Test the 8.5 Crystal Report. Expect the version number in the *.RPT file to match the version number in the JSON definition file.
        $report = New-Object CrystalDecisions.CrystalReports.Engine.ReportDocument
        $CR85ReportPath = "$workingFolder\installedClient\" + $reportDefinition.reportName
                
        try{
            $report.Load($CR85ReportPath)
        }catch{
            Fail("Unable to load RPT file $CR85ReportPath")
            continue
        }        
        
        $cr85Version = $report.DataDefinition.FormulaFields["ESReportVersion"].Text
        
        if($reportDefinition.version -ne $cr85Version) {
            Fail("$($reportDefinition.reportCode) JSON version $($reportDefinition.version) does not match the Crystal 8.5 file's version $($cr85Version)")
            $failCount++
        }        
    }

    if($failCount -ne 0) {
        Fail("$failCount Crystal Report files have mismatched version numbers")
    }
    else {
        Pass("All Crystal Report files have correct version numbers")
    }    
}

# PROGRAM

# Make sure the file exists
if([IO.File]::Exists($ReportZipPath) -eq $false) {
    Fail("Couldn't find file $ReportZipPath")
    exit 1
}
# Make sure it's a ZIP file
if([IO.Path]::GetExtension($ReportZipPath) -ne ".zip") {
    Fail("File $ReportZipPath is not a ZIP archive")
    exit 1
}

# Unzip the ZIP file so the files are available to us
$zipParentFolder = [IO.Path]::GetDirectoryName($ReportZipPath)
$workingFolder = [IO.Path]::Combine($zipParentFolder, [IO.Path]::GetFileNameWithoutExtension($ReportZipPath))
[System.IO.Compression.ZipFile]::ExtractToDirectory($ReportZipPath, $workingFolder)

Run-Tests

# All done. Clean up the working folder
rmdir $workingFolder -Force -Recurse

# Set exit code
if($globalFailures -ge 1) {
    exit 1
}
else {
    exit 0
}