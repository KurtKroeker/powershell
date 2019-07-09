PowerShell FAQs
================

## TOC
* [How does PowerShell handle TLS?](#tls-handling)

## <a name="tls-handling"></a>How does PowerShell handle TLS?
PowerShell is configured to make all web requests using TLS 1.0, so if you enable TLS 1.1+ on your web server, you'll quickly discover that Invoke-RestMethod and Invoke-WebRequest calls will fail, perhaps with an error message like this:

```The request was aborted: Could not create SSL/TLS secure channel.```

You can configure PowerShell to communicate with TLS 1.1 and 1.2 by modifying the ServicePointManager's SecurityProtocol setting. Try running this snippet in PowerShell and retry your request:

```[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12;```

Please note that this will ONLY affect your current PowerShell session. To make it stick, add this line to your PowerShell Profile.