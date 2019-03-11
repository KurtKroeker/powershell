#
# This script illustrates how the ampersand "call" operator works
#

# GOOD
#dotnet C:\ps\concepts\ThermaCAPtureStats.dll -search "kurt"

# GOOD
Invoke-Command "dotnet c:\ps\concepts\ThermaCaptureStats.dll -search 'dave'"

# BAD