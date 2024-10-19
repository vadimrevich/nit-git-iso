<#
.SYNOPSIS
    This Script will Expand TXTEDIT.zip Archive
.DESCRIPTION
    This Script will Expand TXTEDIT.zip Archive
    at the User"s Downloads Folder on Windows 10.0 
    Core/Desktop Local Server
.NOTES
    File name: Expand-Archive.TXTEDIT.ps1
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
# EXATXED
# This Script will Expand TXTEDIT.zip Archive
###########################################################

### Set Variables
#
#
$CurDir = (Get-Item .).FullName
$ParentDir = (Get-Item ..).FullName


### Defivative Variabled
$anArchive = Join-Path -Path $ParentDir -ChildPath "TXTEDIT\TXTEDIT.zip"
$aCRNITISOScript = Join-Path -Path $ParentDir -ChildPath "PREPARE\CRNITISO.ps1"


### Set Functions
#
function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

function Check-AllPeths {

    if( (Test-Path -Path $anArchive) -eq $false ) { 
        Write-Host "Check Integrity Error! $anArchive is not Found."
        return $false
    }
    if( (Test-Path -Path $aCRNITISOScript) -eq $false ) {
        Write-Host "Check Integrity Error! $aCRNITISOScript is not Found."
        return $false
    }
    return $true
}

function Expand-Archive.TXTEDIT {

    if( (Check-AllPeths) -eq $false ) {
        Write-Host "Check Integrity Error Occur!"
        return 1
    }

    $ALocalPath = & $aCRNITISOScript
    Expand-Archive -Path $anArchive -DestinationPath $ALocalPath -Force
    return 0
}

### Run Payload

return Expand-Archive.TXTEDIT
