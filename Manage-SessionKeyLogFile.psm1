<#

.SYNOPSIS
An attempt at simplifying the creation or removal of an environment variable called "SSLKEYLOGFILE".
Current versions of Chrome, Chromium, or Firefox - and their variants - will look for this environment variable during startup, and subsequently log each TLS session's master secrets to a TXT file.
This text file can then be used to decrypt SSL connections captured in a Wireshark packet trace: https://wiki.wireshark.org/SSL

.DESCRIPTION
This module exports 2 functions:
    Enable-SessionKeyLogFile
    Disable-SessionKeyLogFile

Their usage scenarios can be displayed with:
Get-Help Manage-SessionKeyLogFile -Examples

.NOTES
Author  : Luís Pinto
Version : 1.0.190308

.EXAMPLE
[PS] > Enable-SessionKeyLogFile
This function will first look for the "SSLKEYLOGFILE" environment variable.
If it isn't found, then it will be created, and pointed to "$HOME\Desktop\SSLKEYLOGFILE.txt"

.EXAMPLE
[PS] > Disable-SessionKeyLogFile
This function also looks for the "SSLKEYLOGFILE" environment variable.
If it is found, then it will be removed.

#>

function Enable-SessionKeyLogFile
{
    # Properties for the "SessionKeyLogFile" Environment Variable:
    $SKLF = @(
        "SSLKEYLOGFILE",                   # Name
        "$HOME\Desktop\SSLKEYLOGFILE.txt", # Value
        "User"                             # EnvironmentVariableTarget
    ) ;

    if ( $SKLFAssert = [Environment]::GetEnvironmentVariable( $SKLF[0], $SKLF[2] ) )
    {
        Write-Warning "Environment variable is already set to:`n$($SKLFAssert)"
    }
    else
    {
        [Environment]::SetEnvironmentVariable( $SKLF[0], $SKLF[1], $SKLF[2] ) ;
        Write-Warning "Environment variable is set to:`n$($SKLF[1])"
    }
} # END Enable-SessionKeyLogFile

function Disable-SessionKeyLogFile
{
    # Properties for the "SessionKeyLogFile" Environment Variable:
    $SKLF = @(
        "SSLKEYLOGFILE",                   # Name
        "$HOME\Desktop\SSLKEYLOGFILE.txt", # Value
        "User"                             # EnvironmentVariableTarget
    ) ;

    if ( ![Environment]::GetEnvironmentVariable( $SKLF[0], $SKLF[2] ) )
    {
        Write-Warning "Environment variable not found under $($SKLF[0])."
    }
    else
    {
        [Environment]::SetEnvironmentVariable( $SKLF[0], $null, $SKLF[2] ) ;
        Write-Warning "Environment variable $($SKLF[0]) was deleted."
    }
} # END Disable-SessionKeyLogFile

Export-ModuleMember -Function * -Alias *
