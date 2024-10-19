/**********************************************************
 * Stop_DefSettings.js
 * This Script will Open a Console with Windows
 * Defender Settings to Sot ad Adjust It
***********************************************************/

// Declare Variables
var aCmd, wsh, fso, shapp, envString, aCmd1;

// Define Variables
aCmd1 = "windowsdefender://Threatsettings";
envString = "%ProgramFiles%\Windows Defender\MSASCui.exe";

// Set an Objects
wsh = new ActiveXObject("WScript.Shell");
fso = new ActiveXObject("Scripting.FileSystemObject");
shapp = new ActiveXObject("Shell.Application");

// Run Payloads...
aCmd = wsh.ExpandEnvironmentStrings(envString);
if( !fso.FileExists( aCmd ) )
    aCmd = aCmd1;
shapp.ShellExecute(aCmd);
