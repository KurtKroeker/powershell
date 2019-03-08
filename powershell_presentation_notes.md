# Why EnergyCAP Developers should love MS PowerShell)
Author: Kurt Kroeker

Last Updated: 3/8/2019

## My PowerShell Background

Back in the day, Miami-Dade County (MDC) needed to put together an automated workflow for data flowing in and out of EnergyCAP. This workflow included supporting 2 environments (Test and Production), importing EDI bills, executing 4 AP interfaces, setting bill flags, calling Installed Client's external task to run audits, and (eventually) calling ECO v3's APIs (V7 didn't exist yet in any form). Logging was required for all of these functions, and they required file manipulation, dealing with JSON data, and even sending emails with summaries of the log. 

Chris Houdeshell recommended PowerShell as a solution to me and helped me get the project off and running, and it grew into the monstrosity now in Josh Condo's capable hands. 

Over the years, I've found more and more uses for PowerShell when automating repetitive tasks in my development work. Some examples are adding a library of time-saving functions to help me get around my repositories and EnergyCAP resources, checking for obvious mistakes in report release ZIPs, creating "mini" report ZIPs and installing them, interacting with external APIs (Localise), and even looking up obscure passwords.

Don't remember how to do it; figure it out and then write a PowerShell script for it!

## What is PowerShell?
- Command-line interface for Microsoft technologies
- Like cmd.exe on steroids; includes everything I can think of from cmd.exe (access to system environment variables)
- Current version number is version 5.0 (Windows 10)

### Why you should like typing instead of mousing
- Simple reason: it's way faster to issue commands with multiple fingers
- Why do you think we have hotkeys in our software???
- Like cmd prompt on steroids

### History lesson

## Why should I care about PowerShell?
- It is EVERYWHERE (all versions of Windows, but now with PowerShell Core, it's cross-platform since )
- Azure-integrated
- It is (now) Open Source!
- It is embedded in Visual Studio Code
- .NET is always available to you

### PowerShell concepts
- script files

PowerShell scripts are stored in files with a "*.ps1" suffix

- commandlets

`Get-Command`

- aliases
- variables
- functions
- 
- ExecutionPolicy

## Kurt's PS Gallery

- Windows PowerShell ISE
- Kurt's "Microsoft.PowerShell_profile.ps1" file

## Tips working with PowerShell
Working with shell scripts
- Love the tab key
- Love pipes
- Love your PowerShell profile
- Love aliases
- Love the up-arrow
- Love $_. when looping

## Resources
- Installing PS on macOS: https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-macos?view=powershell-6
- 