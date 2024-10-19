<#
.SYNOPSIS
    This Script will Create nit-iso Directory
.DESCRIPTION
    This Script will Create nit-iso Directory
    at the User"s Downloads Folder on Windows 10.0 
    Core/Desktop Local Server
.NOTES
    File name: Create.nit-iso.ps1
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
# CRNITISO
# This Script will Create nit-iso Directory
###########################################################

### Set Variables
#
$MyDownloads = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
$MyDocuments = [Environment]::GetFolderPath("MyDocuments")
$MyDesktop = [Environment]::GetFolderPath("Desktop")
$ParentDir = (Get-Item ..).FullName
$aUserProfile = $env:UserProfile

$aDir = "nit-iso"

### Defivative Variabled


### Set Functions
#
function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

function Check-AllPeths {

    if( (Test-Path -Path $MyDownloads) -eq $true ) { return $MyDownloads }
    if( (Test-Path -Path $MyDocuments) -eq $true ) { return $MyDocuments }
    if( (Test-Path -Path $aUserProfile) -eq $true ) { return $aUserProfile }
}

function Create.nit-iso {

    $ALocalPath = Check-AllPeths
    $ALocalPath = Join-Path -Path $ALocalPath -ChildPath $aDir
    if( (Test-Path -Path $ALocalPath) -ne $true) {
        & mkdir $ALocalPath
    }
    return $ALocalPath
}

### Run Payload

return Create.nit-iso
