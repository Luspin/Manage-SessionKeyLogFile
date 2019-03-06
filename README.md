# Manage-SessionKeyLogFile
An attempt at simplifying the creation or removal of an environment variable called **SSLKEYLOGFILE**.  
Current versions of Chrome, Chromium, or Firefox - and their variants - will look for this environment variable during startup, and subsequently log each TLS session's master secrets to a TXT file.  
This text file can then be used to decrypt SSL connections captured in a Wireshark packet trace: https://wiki.wireshark.org/SSL
  
## Installation
This module can be downloaded and imported into a PowerShell session:  
`[PS] > Import-Module .\Manage-SessionKeyLogFile.psm1`  
  
It is also published in the [PowerShell Gallery](https://www.powershellgallery.com/packages/Manage-SessionKeyLogFile/1.0.190307 "Manage-SessionKeyLogFile - 1.0.190307"), so it can be easily installed¹ and updated² via PowerShell:  
¹`[PS] > Install-Module -Name Manage-SessionKeyLogFile`  
²`[PS] > Update-Module -Name Manage-SessionKeyLogFile`
  
## Usage Examples
`[PS] > Enable-SessionKeyLogFile`  
This function will first look for the **SSLKEYLOGFILE** environment variable.  
If it isn't found, then it will be created, and pointed to `$HOME\Desktop\SSLKEYLOGFILE.txt`  
  
`[PS] > Disable-SessionKeyLogFile`  
This function also looks for the **SSLKEYLOGFILE** environment variable.  
If it is found, then it will be removed.  