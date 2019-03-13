#
# Gratefully stolen from https://michlstechblog.info/blog/powershell-export-excel-workbook-as-csv-file/
#

param(
    $ExcelFileName
)

# Validate the Excel file exists
if([IO.File]::Exists($ExcelFileName) -eq $false) {
    throw "No file here at $ExcelFileName"
}

# Get I/O paths in order
$csvDir = [IO.Path]::GetDirectoryName($ExcelFileName)
$csvFileName = [IO.Path]::GetFileNameWithoutExtension($ExcelFileName) + ".csv"
$fullCsvPath = [IO.Path]::Combine($csvDir, $csvFileName)

# Open in Excel, select the 1st worksheet, and save the file as CSV
$excel = New-Object -ComObject Excel.Application
$excelDoc = $excel.Workbooks.Open($ExcelFileName)
$worksheet = $excelDoc.Worksheets.item(1)
$worksheet.Activate()
$excelDoc.SaveAs($fullCsvPath,[Microsoft.Office.Interop.Excel.XlFileFormat]::xlCSVWindows)

# Close Excel
$excelDoc.Close()

# Open the containing folder of our CSV
explorer $csvDir