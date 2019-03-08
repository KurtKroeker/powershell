# Why EnergyCAP Developers should love MS PowerShell)
Author: Kurt Kroeker

Last Updated: 3/8/2019

## My PowerShell Background

Back in the day, Miami-Dade County (MDC) needed to put together an automated workflow for data flowing in and out of EnergyCAP. This workflow included supporting 2 environments (Test and Production), importing EDI bills, executing 4 AP interfaces, setting bill flags, calling Installed Client's external task to run audits, and (eventually) calling ECO v3's APIs (V7 didn't exist yet in any form). Logging was required for all of these functions, and they required file manipulation, dealing with JSON data, and even sending emails with summaries of the log. 

Chris Houdeshell recommended PowerShell as a solution to me and helped me get the project off and running, and it grew into the monstrosity now in Josh Condo's capable hands. 

Over the years, I've found more and more uses for PowerShell when automating repetitive tasks in my development work. Some examples are adding a library of time-saving functions to help me get around my repositories and EnergyCAP resources, checking for obvious mistakes in report release ZIPs, creating "mini" report ZIPs and installing them, interacting with external APIs (Localise), and even looking up obscure passwords.

Don't remember how to do it; figure it out and then write a PowerShell script for it!

We mentioned a couple weeks ago that we wanted to reduce dependency on specialists for things we depend upon. Becoming more comfortable with PowerShell is a good way to move this initiative forward.

## What is PowerShell?
- Command-line interface for Microsoft technologies
- Like cmd.exe on steroids; includes everything I can think of from cmd.exe; access to system environment variables, directory navigation, execution of scripts, file I/O
- Current version number is version 5.0 (Windows 10)

### History lesson

PowerShell available as far back as Windows XP. Early versions 

## Why should I care about PowerShell?
- It is EVERYWHERE (all versions of Windows, but now with PowerShell Core, it's cross-platform and open source since around August 2016)
    - It's even in our codebase: `C:\ecap\energycap\contrib\Loco`, `build.ps1`, etc.
- Azure-integrated
- It is (now) Open Source!
- It is embedded in Visual Studio Code
- .NET is always available to you

### PowerShell concepts
- script files

PowerShell scripts are stored in files with a "*.ps1" suffix. They may have code for a single function.

- commandlets

Commandlets are basically PowerShell functions which encompass programmatic work of some kind. Think of them as functions.

Structure of the commands is "Verb-Noun"

E.g. `Get-Command` will get you all the available commands in the PowerShell ecosystem. Includes Windows cmdlets, 3rd-party cmdlets, and your custom cmdlets.

If you're good about naming your functions, you can even easily filter the commandlets with the `-Verb` and `-Noun` params to `Get-Command`

- aliases

PowerShell automatically creates aliases for the cmdlets. Many of them have been borrowed from other CLIs to make PowerShell easy to use for Unix and Linux users.

E.g. `dir`, `ls`, and `gci` are all aliases for the `Get-ChildItem` cmdlet.

- variables

PowerShell variables are extremely flexible. They are *not* type safe unless you explicitly set the object type during initialization, and even then, PowerShell is happy to convert types for you if a conversion exists.

- functions

While you can contain PowerShell code at the file level, you can also declare multiple code functions within a single PS script file. These can be available within a single PS script execution or, when loaded, they can be 

`
function GetRandomNumber()
{
    $rand = Get-Random -Maximum 100 -Minimum 0
    return $rand
}
`

- operators

    -eq, -ne, -gt, -like, -and, -or

## Tips working with PowerShell

### Things to Love

- Love the tab key

PowerShell cmdlets do not display their arguments, and you're not using your mouse, so you can't hover over and see what's available in the PowerShell prompt. Use the tab key to view the available arguments and, in some cases, their possible arguments.

- Love pipelines and $_.

You can avoid traditional for-loops by "piping" the results of one command into another. PowerShell gives you a powerful contextual

`ForEach-Object` and `Where-Object`

- Love your PowerShell profile

If you get tired of loading PS1 files whenever you want a common function available, add the functions you use the most to your Microsoft.PowerShell_profile.ps1 file. Save it to your C:\Users\kurtk\Documents\WindowsPowerShell folder. You might even want to put it in source control.

- Love the up-arrow

This is common to most CLIs, but you can always get your commands back by hitting the up arrow to get the previous command, even from session to session.

- Love hash tables

If you want a quick and dirty object or set of objects to work with, you'll love hash tables. They're easy to initialize, and look a lot like dynamic objects in C# or regular objects in JavaScript:

`$myHashTable = { Name = "Kurt Kroeker"; Age = 31; Occupation = "Software Guy" }`

They even give you autocomplete for properties!

- Love working with JSON and CSV

PowerShell comes with niceties for working with data in CSV and JSON format:

`ConvertFrom-CSV` and `ConvertTo-Csv`
`ConvertFrom-Json` and `ConvertTo-Json`

- Windows PowerShell ISE

From Start Menu: "PowerShell ISE"

Nice IDE (or...ISE!) for composing and debugging PowerShell commands. Includes variable inspection, debugging with step-through and step-over, etc.

From PowerShell: `ise` or `powershell_ise`

### Gotchas

Working with strings
- Watch your delimiters!

PowerShell allows both single and double quotes to be used for delimiters. However, only double quotes honor string interpolation. Compare the following statements.

`$foo = "foo"`
`"we have some $foo string interpolation here"`
`'Sorry bub, no $foo string interpolation here'`

While you can usually choose single or double quotes when working with short strings, when you have to work with stringified JSON, you might have both single and double quotes in the data. Here-Strings are your friend:

`$json = @"
{"placeCode":"KURTS_APOSTROPHIED_BUILDING","placeInfo":"Kurt's Apostrophie'd \"Building\"","parentPlaceId":1,"placeTypeId":2,"primaryUseId":null,"weatherStationCode":"UNV","buildDate":null,"address":{"addressTypeId":"1","country":"US","line1":"","line2":"","city":"State College","state":"PA","postalCode":"16803","latitude":"","longitude":"","weatherStationCode":"UNV"}}
@"

`ConvertFrom-Json $json`

- Old code on the internet

Since PowerShell has evolved quite a bit over time, make sure you're always checking the timestamps on the articles and code samples you read. Something that used to be really hard (e.g. JSON manipulation before PowerShell 3.0 and `ConvertFrom-Json`) might have become really easy.

- Is it an array?

Sometimes you may find that variables which you expected to be an array. For example, the much-used `Get-ChildItem` returns an array of files OR a single file (if there was only 1). Fore example:

`(gci *.ps1) -is [system.array]`
`(gci *.dll) -is [system.array]`

- Calling assemblies with arguments

Getting the syntax right was super frustrating when I wanted to execute an EXE with some arguments. However, I think this has gotten better with more recent versions of PowerShell. Here's an example of callings some assemblies with arguments from PowerShell:

`dotnet .\ThermaCAPtureStats.dll -search "vance"`

- . vs. .\

When you're navigating directory structures in PS, you can execute PS1 files directly by using the `.\myFileName.ps1` syntax. The command as expressed here will simply RUN the script.

However, if you use the period, you can *include* the PS1 module for use, if it contains functions you want to use: `. .\myFileName.ps1` will both *execute* the script AND register the functions for use within the PowerShell session.

Sometimes you'll find that when you're working with a list of things which *might* have 0, 1, or multiple objects, your scripts will hit errors when you're *expecting* an array but actually *get* a single object.

## Resources
- Installing PS on macOS: https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-macos?view=powershell-6
- Playing sounds with PowerShell: https://devblogs.microsoft.com/scripting/powertip-use-powershell-to-play-wav-files/
- Is my PS variable an array or not: http://thephuck.com/scripts/easy-way-to-check-if-your-powershell-variable-is-an-array-or-not/
- Type Safety in PowerShell: http://www.winsoft.se/2009/01/type-safety-in-powershell/
- PowerShell tutorial: https://www.tutorialspoint.com/powershell/index.htm
- PowerShell in Wikipedia: https://en.wikipedia.org/wiki/PowerShell
