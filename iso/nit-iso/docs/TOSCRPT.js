/*****
 * toScripts.js
 * Script will Open the ..\scripts Directory on Disk
 */

/**********************************************************
 * Check_Registry_Key
 * This Function Checks a Registry Node
 *
 * PARAMETERS:	aKey as a String
 * RETURNS: 	0 if Success
 *				1 if Integrity Error
 *				2 if aKey not Found or not Assigned
**********************************************************/
function Check_Registry_Key(aKey){
	var wShell, theKey, theValue;
	wShell = new ActiveXObject("WScript.Shell");
	try {
		theKey = wShell.RegRead(aKey);
	}
	catch(err) {
		return 1;
	}
	if( typeof(theKey) == null)
		return 2;
	else if( typeof(theKey) == "string" && theKey.length == 0)
		return 2;
	else
		return 0;
}
/**********************************************************
 * Get_ARegistryStr_Value
 * This Function Get a Key Value of the Windows Registry
 *
 * PARAMETERS:	aKey
 * RETURNS:		a Registry Key if Success
 *				an Empty String if Error Occuur
**********************************************************/
function Get_ARegistryStr_Value(aKey){
	var wShell, theValue, iFlag;
	wShell = new ActiveXObject("WScript.Shell");
	iFlag = Check_Registry_Key(aKey);
	if( iFlag != 0 )
		return "";
	theValue = wShell.RegRead(aKey);
	if(typeof(theValue) != "string")
		return "";
	else
		return theValue;
}
/**********************************************************
 * Get_Downloads_Folder
 * This Function Get a Download Folder from the Windows Registry
 *
 * PARAMETERS:	NONE
 * RETURNS:		a Download Folder Path if Success
 *				an Empty String if Error Occuur
**********************************************************/
function Get_Downloads_Folder(){
	var fso, aValue;
	var SHCU_NODE, SHCU_Downloads, FO_Downloads;
	SHCU_NODE = "HKCU\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Shell Folders\\";
	FO_Downloads = "{374DE290-123F-4565-9164-39C4925E467B}";
	SHCU_Downloads = SHCU_NODE + FO_Downloads;
	fso = new ActiveXObject("Scripting.FileSystemObject");
	aValue = Get_ARegistryStr_Value(SHCU_Downloads);
	if(aValue.length == 0) {
		WScript.Echo("\nError!\nDownloads Folder is not Found in Registry.");
		return "";
	}
	else {
		if(!fso.FolderExists(aValue)) {
			WScript.Echo("\nError!\nThe Downloads Folder is not Found at File System.");
			return "";
		}
		else {
			// WScript.Echo("\nSucces!\nA Downloads Folder = " + aValue);
			return aValue;
		}
	}
}
/**********************************************************
 * Get_Current_Folder
 * This Function Get a Current Folder
 *
 * PARAMETERS:	NONE
 * RETURNS:		a Download Folder Path if Success
 *				an Empty String if Error Occuur
**********************************************************/
function Get_Current_Folder(){
	var fso, aValue, curScript;
	fso = new ActiveXObject("Scripting.FileSystemObject");
	curScript = WScript.ScriptFullName;
	aValue = fso.GetParentFolderName(curScript);
	if( !fso.FolderExists(aValue)) {
		WScript.Echo("\nError!\nCurrent Folder " + aValue + " is not Found." );
		return "";
	}
	else {
		return aValue;
	}
}
/**********************************************************
 * Get_Scripts_Folder
 * This Function Get a Current Folder
 *
 * PARAMETERS:	NONE
 * RETURNS:		a Download Folder Path if Success
 *				an Empty String if Error Occuur
**********************************************************/
function Get_Scripts_Folder(){
	var fso, aValue;
	fso = new ActiveXObject("Scripting.FileSystemObject");
	aValue = Get_Current_Folder();
	if(aValue.length == 0) {
		WScript.Echo("\nError!\nA Current Folder is not Found at Current Disk.");
		return "";
	}
	else {
		aValue = fso.GetParentFolderName(aValue);
		aValue += "\\scripts";
		if(!fso.FolderExists(aValue)) {
			WScript.Echo("\nError!\nThe scripts Folder " + aValue + " is not Found at File System.");
			return "";
		}
		else {
			// WScript.Echo("\nSucces!\nA Script Folder = " + aValue);
			return aValue;
		}
	}
}
/**********************************************************
 * Goto_Scripts_Folder_Explorer
 * This Function will Go to a Downloads Folder
 * with Explorer as Ordinary User
 *
 * PARAMETERS:	NONE
 * RETURNS:		0 if Success
 *				1 if Error Occur
**********************************************************/
function Goto_Scripts_Folder_Explorer(){
	var fso, wShell;
	var strPath, strCmd, strExe, envProc;
	// Define Objects
	fso = new ActiveXObject("Scripting.FileSystemObject");
	wShell = new ActiveXObject("WScript.Shell");
	envProc = wShell.Environment("PROCESS");
	strExe = envProc("SystemRoot") + "\\" + "explorer.exe";
	if(!fso.FileExists(strExe)) {
		WScript.Echo("\nSystem Integrity Error!\nThe File: " + strExe + " is not Found!");
		return 1;
	}
	// Run Payloads
	strPath = Get_Scripts_Folder();
	if(strPath.length == 0)
		return 1;
	else {
		if(!fso.FolderExists(strPath))
			return 1;
		else {
			strCmd = strExe + " /e, " + "\"" + strPath + "\"";
			wShell.Run(strCmd);
			return 0;
		}
	}
}

var iRes;
iRes = Goto_Scripts_Folder_Explorer();
// WScript.Echo(iRes);
