# Why Developers should love Powershell

Author: Kurt Kroeker
Last Updated: 10/25/2022

## 1. Title Slide

Intro
* Welcome to my talk, "Why Developers should love Powershell"!
* This is my second time giving this talk, the last time was at TechBash 2019, pre-COVID!
* I'm very enthusiastic about PowerShell, it's one of the most-used tools in my digital toolbox!

### About This Talk/Agenda
* **Talking**
    * Why should I care about PowerShell?
* **Demos**
    * Introduction to PowerShell
    * Tips working with PowerShell
    * PowerShell Gotchas
* **Resources**
* **Q & A**

## 2. About Kurt

* Kurt Kroeker, Sr. Integration Software Developer at EnergyCAP, LLC for 14 years
    * Currently working as part of the integrations team developing services that integrate with our flagship software, EnergyCAP.
* Lifelong State College, PA resident - Penn State University grad ("WE ARE!")
* Father of 3 girls and a boy: Josephine, Cecilia, Eleanor, George
* In my free time, I enjoy playing music with people. I play fiddle, mandolin, and guitar, I occasionally play out in a couple of bands located in the State College area.

## 3. PowerShell and Me

My introduction to PowerShell began with a problem: need to glue together various pieces put together an automated workflow for data flowing in and out of EnergyCAP. This workflow included:

* Supporting multiple environments
* Invoking compiled executables
* Invoking REST APIs
* Reading/writing text files
* Parsing JSON

What kind of technology could glue all these things?

One of our technical leads recommended PowerShell, and the success of that project resulted in PowerShell making its way into many different solutions.

Over the years, I've found more and more uses for PowerShell when automating repetitive tasks in my development work. 

Some examples are adding a library of time-saving functions to help me get around my repositories and EnergyCAP resources (which I will show you how to do), checking for frequently-occurring manual mistakes in report release ZIPs, interacting with external APIs, web scraping, managing credentials for my scripts, and a variety of other uses.

It's become a tenet of mine: Don't just remember how to do it; figure it out and then write a PowerShell script to do it! I'm not the only one thinking this way. There is a public gallery of PowerShell scripts and modules which are easy to install and use in your own projects.

## 4, 5. PowerShell Multi-Tool

"When all you have is a hammer, every problem looks like a nail." 
* I'd like to encourage you to think of PowerShell as your trusty multi-tool where you can just add your own blades over time
* This is true of all scripting languages, but PowerShell brings a lot of great stuff along with it

Informal poll: Raise hand if you are a...
* Rank beginner to Powershell
* Pretty decent with it
* You're THE POWERSHELL HERO

Modernization - a thoughtful reimagining of the commandline that embraces modern technologies and keeps getting better
Orchestration - supports orchestration of diverse processes to create powerful workflows
Navigation - similar experience navigating the file system, registry keys, and object hierarchies
Automation - don't repeat those manual, error-prone tasks or give yourself carpal tunnel syndrome
Democritization - open source, personalizable, and extensible via the PowerShell community

## 6. What is PowerShell?
- Originally called "Monad", PowerShell is Microsoft's reimagined, open source, .NET-based command-line interface for working with their technologies.
    - It is a successor to cmd.exe and VBScript which is informed by the strengths and weaknesses of each, as well as being influenced by other scripting languages
- From the command line, provides access to environment variables, PATH variable access, drive, registry, and directory navigation, execution of scripts, file I/O, interaction with APIs, PC administration, Azure automation, and much more.
- You'll soon find that PowerShell is a strongly opinionated technology which, when the syntax and fundamental concepts are understood, make it very natural to discover and extend.

## 7. Why should I care about PowerShell?

1) It is POWERFUL
    - Scripting, especially when it has hooks into as many things as PowerShell does, helps you do a lot of otherwise time-consuming stuff very quickly and accurately
    - It's GREAT for chopping data quickly, especially XML, CSV, and JSON
    - Your favorite .NET APIs are available to you. INTERACT: How many .NET developers do we have here?
    - It's fast - you can type and tab faster than you can point and click, and available PowerShell IDEs are lightweight and well-featured. The rinse/repeat cycle is very fast.
2) It is EVERYWHERE
    - It's in Windows
    - It's in Azure
        - Deploy ARM
        - Nice suite of built-in PowerShell commands for working with Azure
    - It's cross-platform and open source
    - It's in your codebase:
        - Automation scripts built for clients like MDC
        - ECAP codebase: `C:\ecap\energycap\contrib\Loco`, `build.ps1`, etc.
        - Reports repository
    - It is embedded into Visual Studio Code
    - Various platforms are intentional providing hooks into Powershell (e.g. OctopusDeploy, JAMS, TeamCity)
2) It is FAMILIAR
    - Thanks to the "aliases" feature, you already have a handle on PS syntax that you bring from other systems
    - C# developers and people familiar with COM objects will enjoy having familiar APIs at their fingertips
    - If you spend the time building up your PowerShell "swiss army knife", you will end up with a very personalized, comfortable experience, even one which can be ported from PC to PC.

### 8. PowerShell concepts

So let's get to some demos and see what PowerShell looks like in action!

- How do you get to the PowerShell console?

* Can get to it from 
    * Start Menu
    * Run interface (Win + r)
    * cmd.exe
* Chances are you might already have a terminal open right in front of you in VS Code
    (Ctrl + Shift + ~)

- Windows PowerShell vs. PowerShell Core

Windows PowerShell -> powershell
- ships with Windows
- version 5.1
- built on .NET 4.5 Framework
- PowerShell basics will still apply if all you have access to is Windows PowerShell, but if it's an option, I recommend installing PowerShell Core.

PowerShell Core -> pwsh
- requires installation
- cross-platform (Windows, Mac OS, Linux)
- built on .NET Core (dotnet 6.0)

- commandlets

Let me introduce you to your first commandlet: `Get-ChildItem`

* Commandlets are PowerShell commands which encompass programmatic work of some kind
* The cmdlets you have available to you in a session are
    * built into PowerShell
    * installed along with other applications
    * installed as part of a module
* Cmdlets are different from PowerShell "functions" in that cmdlets are written in compiled .NET code while functions are written in pure PowerShell syntax

Conventional structure of both commandlets and functions is "Verb-Noun"
    Consistent use of this convention unlocks PowerShell's discoverability; all commandlets are structured in this way
This is why I said earlier that PowerShell is an opinionated technology.

Let's learn a few more commandlets that will help you discover the power that you have access to.

E.g. `Get-Command` will get you all the available commands in the PowerShell ecosystem. Includes Windows cmdlets, 3rd-party cmdlets, and your custom functions.
    get-command -Verb Update
    get-command -Noun Item
    Get-Command -Module EnergyCap.PowerShell

If you're good about naming your functions, you can even easily filter the commandlets with the `-Verb` and `-Noun` params to `Get-Command`. 
You lose this benefit if you don't stick to the Verb-Noun format. 

E.g. `Get-Help` gets help documentation for the provided commandlet. `-Online` parameter will even bring you directly to online help for the commandlet.
    get-help get-childitem

E.g `Show-Command` discovered while prepping for this talk; allows you to browse available commandlets by module!
    show-command dir
    show-command

E.g `Get-Verb` gets a list of verbs approved for use in PowerShell commands

- working with objects, not text

In PowerShell, you're working with complex objects. You may find this a mindshift from working in other CLIs which involve only working with strings.
Each commandlet accepts objects as input and returns them as output, and the fact that you can "pipe" objects from commandlet to commandlet is very powerful.

To understand what kind of object you're working with, `Get-Member` is a useful command to know. If you want to get a list of all the available properties and methods for a PS object, this is what you need.

- passing parameters

PowerShell commandlets and functions can accept parameters
    * by position `Get-ChildItem *.xlsx`
    * by name `Get-ChildItem -Filter *report*`
    * mixture of both `Get-ChildItem *.zip -Filter *bar* -File`
    * splatting

Parameter values in powershell can be passed
    * without quotes
    * with single quotes (no string interpolation)
    * with double quotes (with string interpolation)

Frequently, parameters for PowerShell commandlets have a limited set of possible values. The CLI is aware of these scenarios, and you can discover them using the TAB key.
    get-command -module <TAB>

- aliases

Aliases are expressions that point to a commandlet.
PowerShell automatically creates aliases for many the cmdlets. Many of them have been borrowed from other CLIs to make PowerShell easy to use for CMD, Unix and Linux users.
Two advantages:
    keeping scripts and commands brief
    lets you personalize your commands while still honoring the Verb-Noun convention

E.g. `dir`, `ls`, and `gci` are all aliases for the `Get-ChildItem` cmdlet.

Remember what I said before about PowerShell being "familiar"? Aliases make it possible for you to come from a bash or cmd background and immediately start getting work done in the PowerShell CLI.

You can see what aliases are available with `Get-Alias` and create your own aliases with `Set-Alias`

- pipelines

    "Pipelines act like a series of connected segments of pipe. Items moving along the pipeline pass through each segment." 

    Commandlets return objects. The pipe operator passes these return objects through to the next commandlet, which can be piped to another, and so on.

    Get-ChildItem
    Get-ChildItem|Where-Object Extension -eq ".docx"
    Get-ChildItem|Where-Object Extension -eq ".docx"|Select-Object Name,BaseName,CreationTime
    Get-ChildItem|Where-Object Extension -eq ".docx"|Select-Object Name,BaseName,CreationTime|ConvertTo-Json

- variables

Running commands is all well and good, but let's move on to storing their inputs and outputs with PowerShell variables using the almighty dollar sign.

`$x = "Hello, world!"`

Variables in PowerShell are extremely flexible. They are *not* type safe unless you explicitly set the object type during initialization, and even then, PowerShell is quite happy to convert types for you if a conversion exists.

Initialize typed variables using square brackets around the type. You can use the fully-qualified type name or the short version: [System.String], [xml]
The square brackets also allow you to cast variables.

You may ask, what are my available variables? Use `Get-Variable` to see.

- script files

After iterating your script in the command line, you want to have it available for use in the future. Here's how you do it:

PowerShell scripts are stored in files with a "*.ps1" suffix. They may have code for a single function, or they may be libraries of functions.
They may even have return values.

You can define input parameters in PS1 files, you can even make them mandatory

param(
    $MyParameter
)

`[Parameter(Mandatory = $true)]`

- functions

While you can contain PowerShell code at the file level, you can also declare multiple code functions within a single PS script file. These can be available within a single PS script execution or, when loaded into session memory, they can be used over and over again.

- operators

    Conditional Operators

    -eq, -ne, -gt, -lt, -like, -and, -or, -not

    `Where-Object, if()`

    Can use -like with wildcard * character

    -match -notmatch -replace -split

    Can use regex operators

    Other Operators

    -whatif

    For some actions which are potentially destructive, you can see what WOULD happen without actually performing the action

    -split

    String splitting

    -is

    Type validation

## Things to Love working with PowerShell

- Love Visual Studio Code with the PowerShell plugin

Get PowerShell debugging, linting, intellisense, and more! While Windows includes the "PowerShell Integrated Scripting Environment (ISE)" for Windows PowerShell, I do 100% of my own PowerShell development in the CLI or VS Code.

- Love comment-based help

I mentioned the high discoverability of PowerShell functionality earlier. Let's take a look at how you can leverage the power of comment-based help.

For your PowerShell script files, you can comment single lines of code using the pound sign # or multiple lines using the gt/lt+pound sign syntax: 
    <# #>

Comment-based help is layered on top of multi-line commenting, and is an opinionated way to represent documentation for your scripts in a way that keeps code changes and documentation in sync.

Get-Help is good for your code, not just pre-packaged code.

- Love the tab key

PowerShell cmdlets do not display their arguments, and you're not using your mouse, so you can't hover over and see what's available in the PowerShell prompt. Use the tab key to view the available arguments and, in some cases, their possible arguments.

Auto-complete ALL the things!

- Love your context - $_

You can avoid traditional for-loops by "piping" the results of one command into another. PowerShell gives you a powerful contextual variable $_. to reference the current item.

`ForEach-Object` and `Where-Object`

- Love your PowerShell profile

If you get tired of loading PS1 files whenever you want a common function available, add the functions you use the most to your Microsoft.PowerShell_profile.ps1 file. You might even want to put it in source control. Discover where it is using the $PROFILE variable.

- Quickly find previous commands

This is common to most CLIs, but you can navigate your previous commands using the up/down arrows

Use Ctrl + R to search your previous commands
Use the left arrow to accept PowerShell's predictive auto-completion

- Love your available options with Ctrl + <SPACE>

- Love hash tables and PSCustomObjects

If you want a concise but powerful dictionary-like object to work with, you'll love hash tables. They're terse to initialize and act a lot like dynamics in C# or JavaScript objects:

`$myHashTable = @{ Name = "Kurt Kroeker"; Age = 31; Occupation = "Software Guy" }`

They even give you autocomplete for properties, including properties with spaces in the names!

To take things to the next level, you can also build PSCustomObjects on the fly.
You can start by initializing the PSCustomObject and then adding members to it

I like to add NoteProperties to construct objects for serialization, analysis
You can also add ScriptMethods to objects to define custom behavior

`Add-Member -InputObject $a -Name TestMethod -Value { Write-Host "You invoked me!" } -MemberType ScriptMethod`

- Love working with JSON and CSV

PowerShell comes with niceties for working with data in XML, CSV and JSON format:

`ConvertFrom-CSV` and `ConvertTo-Csv`
`ConvertFrom-Json` and `ConvertTo-Json`

`Format-Table` may be useful to you as well when you're trying to view data.

- Love your API interactions

**DEMO: demo_apiCalls.ps1**

- Love modules

Show PowerShell Gallery
Custom PowerShell module that we publish to a private NuGet repository for our internal users to help with client automation
Az module useful for working with Azure resources

- Love .NET!

I just need to keep pointing out that everything you're seeing in this session is in the context of the .NET or .NET core framework. The same structures, APIs, libraries are available to you throughout, so it will feel very familiar to .NET developers.

### Gotchas

#### ExecutionPolicy
PowerShell has some very nice security features to protect users from malicious script execution, one of them being the ExecutionPolicy.

`Get-ExecutionPolicy`

There are a number levels of ExecutionPolicy. From most stringent to least stringent:
* Restricted - terminal scripting only; can't execute script files
* AllSigned - all script files can be executed only if they're signed
* RemoteSigned - remote script files can be executed only if they're signed
* Default - sets the default execution policy
* Bypass - nothing is blocked and there are no warnings or prompts

If you find script files or modules online that you want to try, you may find yourself having to negotiate the ExecutionPolicy, which may require elevated access to change. 
I recently hit this with a script I needed to resize a batch of images. I couldn't install the module; but I reviewed the script within the module and easily adapted it.

Resource: https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.security/set-executionpolicy?view=powershell-6
Resource: https://gallery.technet.microsoft.com/scriptcenter/Resize-Image-A-PowerShell-3d26ef68

#### Working with strings
- Watch your quotes!

PowerShell allows both single and double quotes to be used for declaring strings. However, only double quotes honor string interpolation. Compare the following statements.

`$foo = "foo"`
`"we have some $foo string interpolation here"`
`'Sorry bub, no $foo string interpolation here'`

While you can usually choose single or double quotes when working with short strings, when you have to work with stringified JSON, you might have both single and double quotes in the data. Here-Strings are your friend:

```
$json = @"
{"placeCode":"KURTS_APOSTROPHIED_BUILDING","placeInfo":"Kurt's Apostrophie'd \"Building\"","parentPlaceId":1,"placeTypeId":2,"primaryUseId":null,"weatherStationCode":"UNV","buildDate":null,"address":{"addressTypeId":"1","country":"US","line1":"","line2":"","city":"State College","state":"PA","postalCode":"16803","latitude":"","longitude":"","weatherStationCode":"UNV"}}
@"

ConvertFrom-Json $json

$json
```

Additionally, if you have a complex object to use with string interpolation, you need to do a little more. Consider this more complex example:

`Get-ChildItem | ForEach-Object { "The length of this file is $_.length" }`
`Get-ChildItem | ForEach-Object { "The length of this file is $($_.length)" }`

In this example, you need to surround the property reference with another $(). Then the interpolation will work correctly.

#### Error handling with $Error
Array of "ErrorRecord" objects representing exceptions encountered in this PS session in DESCENDING order. The 0th ErrorRecord is the most recent.

This may be helpful for you to know about when tracking and handling exceptions in your script code and examine the exceptions more deeply. The actual .NET exception object is there in the properties when you drill down.

#### Relative path handling
One of the most awkward PS-isms I've had to deal with, which is an issue in all versions that I've used, is handling (or lack thereof) of relative paths to files and directories.

#### Old code on the internet
Since PowerShell has evolved a LOT over time, make sure you're always checking the timestamps on the articles and code samples you read. Something that used to be difficult (e.g. JSON manipulation before PowerShell 3.0 and `ConvertFrom-Json`, getting response bodies from web request errors, etc.) might have become really easy.

#### Is it an array?
Sometimes you may find that variables which you expected to be an array are not. For example, the much-used `Get-ChildItem` returns an array of files OR a single file (if there was only 1). For example:

`(gci *.ps1) -is [system.array]`
`(gci *.dll) -is [system.array]`

Scenarios like this expose themselves where you expect a loop to execute multiple times but they error! `Get-Service` also subject to this effect.

Resource: https://devblogs.microsoft.com/powershell/same-command-different-return-types/

**DEMO: "length" property means two different things for results from Get-ChildItem**

If you find that you're in a scenario like this, you can always check for array-ness to make sure you code produces the expected results.

#### Calling assemblies with arguments
Getting the syntax right was super frustrating when I wanted to execute an EXE with some arguments. It's easy to get confused by PowerShell's behavior when it comes to the syntax for passing arguments into EXEs. Here's an example of calling some assemblies with arguments from PowerShell:

**DEMO: demo_consoleArgs.ps1**

#### PowerShell and TLS
PowerShell is configured to make all web requests using TLS 1.0, so if you're making web requests against a web server with TLS 1.1+ enabled, you'll quickly discover that Invoke-RestMethod and Invoke-WebRequest calls will fail, perhaps with an error message like this:

```The request was aborted: Could not create SSL/TLS secure channel.```

You can configure PowerShell to communicate with TLS 1.1 and 1.2 by modifying the ServicePointManager's SecurityProtocol setting. Try running this snippet in PowerShell and retry your request:

```[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12;```

Please note that this will ONLY affect your current PowerShell session. To make it stick, add this line to your PowerShell Profile.

## Subjects Not Demoed
- Splatting arguments into functions/commandlets
    - Use @ instead of $ for splatting...
- Azure resource interactions
- PC user and administrative management
- GUIs and PowerShell
    - Building using Windows Forms...I prefer named parameters, Read-Host, Get-Credential
    - I saw a desktop automation module out there
    - Selenium has a PowerShell module; it's nice :)
- PSCustomObject creation
- Add-Type to use DLLs, even create your own!
- try/catch with PowerShell; error handling with $Error array of "ErrorRecord" types with the exception type and other details within, if you drill down.

## Q & A

- Q: Why should I use PowerShell Core vs. regular?
    - [NO LONGER TRUE!] - PSCore feature set is smaller b/c .NET Core is newer
    - Run PS-based automation in other OSs
    - .NET Core generally faster than .NET Framework
    - PowerShell core is open source; see the guts
    - NOTE: can't use ISE in PSCore...use VSCode instead

- Q: Why should I use Visual Studio Code vs the ISE?
    - VS Code
        - Is much nicer for managing projects/workspaces
        - More customizable than the ISE (e.g. default terminals for PS or PSCore)
        - Debugging experience was prettier
        - NOW NO REASON NOT TO USE IT
    - ISE
        - Already installed everywhere
        - Decent debugging experience
        - ISE is not included as part of PowerShell Core; you'll have to use VS Code

## Resources
- Installing PS on macOS: https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-macos?view=powershell-6
- Is my PS variable an array or not: http://thephuck.com/scripts/easy-way-to-check-if-your-powershell-variable-is-an-array-or-not/
- Type Safety in PowerShell: http://www.winsoft.se/2009/01/type-safety-in-powershell/
- PowerShell tutorial: https://www.tutorialspoint.com/powershell/index.htm
- PowerShell in Wikipedia: https://en.wikipedia.org/wiki/PowerShell
- Testing PowerShell scripts: https://devblogs.microsoft.com/scripting/what-is-pester-and-why-should-i-care/
- PowerShell dev in VS Code: https://docs.microsoft.com/en-us/powershell/scripting/components/vscode/using-vscode?view=powershell-6
- Save Excel as CSV: https://michlstechblog.info/blog/powershell-export-excel-workbook-as-csv-file/
- Setting ExecutionPolicy: https://www.mssqltips.com/sqlservertip/2702/setting-the-powershell-execution-policy/
- Version of .NET used by PowerShell: https://stackoverflow.com/questions/3344855/which-net-version-is-my-powershell-script-using
- Niceties for working in git with PowerShell - posh-git: https://github.com/dahlbyk/posh-git
- Microsoft Powershell Gallery (https://www.powershellgallery.com/)