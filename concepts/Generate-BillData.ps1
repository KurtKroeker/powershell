#
# Make some test bill data
#

param(
    $numberOfYears = 1,
    $accountCode = "TESTACCOUNT",
    $vendorCode = "TESTVENDOR",
    $meterCode = "!AUTO!",
    $useUnit = "KWH",
    $demandUnit = $null
)

$csv = "accountcode,StartDate,EndDate,A/C/E,metercode,V/P/R,vendorcode,StatementDate,controlcode,DueDate,billperiod,ACCTPERIOD,invoicenumber,billNote,TOTALCOST:USDOLLARS:Total Cost,USE:$($useUnit):Usage,DEMAND:$($demandUnit):Demand,*EndofRecord
"

$startDate = [datetime]::Now.AddYears(1)

for($i = 1; $i -lt $numberOfYears * 12; $i++){

    
    $endDate = $startDate.AddMonths(1)
    $billingPeriod = $endDate.ToString("YYYYMM")
    $totalCost = Get-Random -Minimum 100 -Maximum 200
    $use = Get-Random -Minimum 100 -Maximum 200
    $demand = Get-Random -Minimum 0 -Maximum 100

    $row = @{ AccountCode = $accountCode; StartDate = $startDate; EndDate = $endDate; ACE = "A"; MeterCode = $meterCode; VPR = ""; VendorCode = $vendorCode;
    StatementDate = $null; ControlCode = $null; DueDate = $null; BillingPeriod = $billingPeriod; AccountPeriod = $null; InvoiceNumber = $null; BillNote = "PowerShell Data";
    TotalCost = $totalCost; Usage = $use; Demand = $demand; EndOfRecord = "x" }   
}