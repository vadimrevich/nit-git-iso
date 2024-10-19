' *********************************************************
' Stop_Defender_Settings.vbs
' This Script will Open the Stop Protection Window of the
' Microsoft Windows Defender on Windows 10+ Computers
' *********************************************************
Dim tCommand

tCommand = CreateObject("WScript.Shell").ExpandEnvironmentStrings("%ProgramFiles%\Windows Defender\MSASCui.exe")
If Not (CreateObject("Scripting.FileSystemObject").FileExists(tCommand)) Then tCommand = "windowsdefender://Threatsettings"
CreateObject("Shell.Application").ShellExecute(tCommand)
