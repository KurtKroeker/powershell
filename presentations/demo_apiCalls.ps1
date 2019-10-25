
# Auth token
# TODO: refresh me!
$token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2VuZXJneWNhcC5jb20vc3ViamVjdCI6Imt1cnQiLCJodHRwczovL2VuZXJneWNhcC5jb20vYXBwbGljYXRpb24iOiJBUEkiLCJodHRwczovL2VuZXJneWNhcC5jb20vZGF0YXNvdXJjZSI6ImRlbW8iLCJodHRwczovL2VuZXJneWNhcC5jb20vb3JnYW5pemF0aW9uIjoiUm9vdCBOb2RlIiwiaHR0cHM6Ly9lbmVyZ3ljYXAuY29tL3RydXN0bGV2ZWwiOiJJbnRlcm5hbFVzZXIiLCJodHRwczovL2VuZXJneWNhcC5jb20vbWV0YSI6Int9IiwiaHR0cHM6Ly9lbmVyZ3ljYXAuY29tL2Vudmlyb25tZW50IjoiIiwiaHR0cHM6Ly9lbmVyZ3ljYXAuY29tL3BhcnRpdGlvbiI6ImRlbW8iLCJodHRwczovL2VuZXJneWNhcC5jb20vdGltZW91dCI6IjQ4MCIsIm5iZiI6MTU3MjAxOTk1MCwiZXhwIjoxNTcyMDQ4NzUwLCJpYXQiOjE1NzIwMTk5NTAsImlzcyI6ImVuZXJneWNhcCIsImF1ZCI6ImVuZXJneWNhcCJ9.Msfgy3chirRrPieLCQVZfH3WEev25BE_2NvpfM6cKEs"
$token

$baseUrl = "https://implement.energycap.com"

$headers = @{
    "Authorization"="Bearer $token";
    "Content-Type"="application/json"
}

# $result = Invoke-WebRequest -Method Get -Uri "$baseUrl/api/v3/vendor" -Headers $headers
# $result
# $result.GetType()
# $result.Content | ConvertFrom-Json | ForEach-Object { $_.vendorInfo }

# $result = Invoke-RestMethod -Method Get -Uri "$baseUrl/api/v3/place" -Headers $headers
# $result.GetType()

# $newVendor = @{
#     "vendorCode" = "ZZZ new Vendor";
#     "vendorInfo" = "ZZZNEWVEND";    
# }
# $newVendor | ConvertTo-Json

# Invoke-RestMethod -Method Post -Uri "$baseUrl/api/v3/vendor" -Headers $headers -Body ($newVendor | ConvertTo-Json)
# Clean up
# Invoke-RestMethod -Method Delete -Uri "$baseUrl/api/v3/vendor/1051" -Headers $headers