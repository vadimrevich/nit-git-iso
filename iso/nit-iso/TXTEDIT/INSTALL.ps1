<#
.SYNOPSIS
    This Script will Copy a Folder with Text Editors
.DESCRIPTION
    This Script will Copy a Folder with Text Editors
    to the User"s Downloads Folder on Windows 10.0 
    Core/Desktop Local Server
.NOTES
    File name: INSTALL.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2024-10-02
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2024-10-02) Script created
    1.0.1 - 
#>
###########################################################
# INSTALL
# This Script will Copy a Folder with Text Editors
###########################################################

### Set Variables
#
$CurDir = (Get-Item .).FullName
$ParentDir = (Get-Item ..).FullName

$anArchiveFile = Join-Path -Path $CurDir -ChildPath "TXTEDIT.zip"
$aCRNITISOScript = Join-Path -Path $ParentDir -ChildPath "PREPARE\CRNITISO.ps1"
$anExpandScript = Join-Path -Path $ParentDir -ChildPath "PREPARE\EXATXED.ps1"


### Defivative Variabled

### Set Functions
#
function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

# Set Functions

function Check-AllPeths {

    if( (Test-Path -Path $anArchiveFile) -eq $false ) { 
        Write-Host "Check Integrity Error! $anArchiveFile is not Found."
        return $false
    }
    if( (Test-Path -Path $aCRNITISOScript) -eq $false ) {
        Write-Host "Check Integrity Error! $aCRNITISOScript is not Found."
        return $false
    }
    if( (Test-Path -Path $anExpandScript) -eq $false ) {
        Write-Host "Check Integrity Error! $anExpandScript is not Found."
        return $false
    }
    return $true
}

function NIT-Install-TXTEDIT {

    
    if( (Check-AllPeths) -eq $false ) {
        Write-Host "Check Integrity Error Occur!"
        return 1
    }
    
    $res = & $anExpandScript
    return 0
   
}

### Run Payloads

#if ((Test-Admin) -eq $false)  {
#    if ($elevated) {
#        # tried to elevate, did not work, aborting
#    } else {
##        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -Window Normal -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
#        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -Window Normal -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
    #}
    #exit
#}

# 'running with full privileges'

#Main function
NIT-Install-TXTEDIT
