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
Version : 1.0.190311

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

    $SKLFAssert = [Environment]::GetEnvironmentVariable( $SKLF[0], $SKLF[2] ) ;

    if ( !$SKLFAssert )
    {
        [Environment]::SetEnvironmentVariable( $SKLF[0], $SKLF[1], $SKLF[2] ) ;
        Write-Warning "Environment variable pointed to:`n$($SKLF[1])"
    }
    else
    {
        Write-Warning "Environment variable is already pointed to:`n$($SKLFAssert)"
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

    $SKLFAssert = [Environment]::GetEnvironmentVariable( $SKLF[0], $SKLF[2] ) ;

    if ( $SKLFAssert )
    {
        [Environment]::SetEnvironmentVariable( $SKLF[0], $null, $SKLF[2] ) ;
        Write-Warning "Removed the environment variable $($SKLF[0])."
    }
    else
    {
        Write-Warning "Couldn't find the environment variable $($SKLF[0])."
    }
} # END Disable-SessionKeyLogFile

Export-ModuleMember -Function * -Alias *
