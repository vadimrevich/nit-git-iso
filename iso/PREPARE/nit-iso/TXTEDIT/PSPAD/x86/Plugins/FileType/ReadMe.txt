PSPad File handling plugin

Idea - each file extension has its own EXE or BAT.
Plugin is used for the file open/save handling if EXE or BAT exists and matches the plugin name to file extension.
Plugin loads file given by input file parameter, transforms it and saves it to output file
You can easily call any command line tool and transform file before PSPad opens it with simple BAT file

PSPad automatically detects encoding: UTF-16LE, UTF-16BE, UTF-8. The rest is considered as ANSI

================================================================================

How it works

Load process:
if you want to open file.xxx PSPad will look if file plugin with name xxx.exe or xxx.bat exists
if yes, PSPad will call plugin with 3 parameters:
-L "existing_file" "temp_file"
plugin opens existing file, do it's job and save it in readable form as temp file name given by 3rd parameter
when plugin ends, PSPad opens temp file and delete it

Save process:
PSPad saves file to temp_file and call plugin with 3 parameters:
-S temp_file target_file
plugin opens temp file, does it's job and save file as target_file
PSPad deletes temp_file when plugin ends

================================================================================
Plugin must support 3 parameters:

syntax: switch InputFile OutputFile

switch: -L|-S

Load file using plugin:
extension.exe -L "existing_file" "temp_file_for_PSPad"

Save file with plugin:
extension.exe -S "temp_file_from_PSPad" "output_file"
================================================================================

BAT plugins example for command line placed in .\Plugins subfolder when BAT is in .\Plugins\FileType
if %1 == -L "%~d0%~p0..\some.exe" %2 %3
if %1 == -S "%~d0%~p0..\some.exe" %2 %3

or

if %1 == -L "c:\some path\some_exe_for_load_file.exe" %2 %3 some_other_parameter(s)
if %1 == -S "c:\some path\some_exe_for_save_file.exe" %2 %3 some_other_parameter(s)

you can see the plugin can be different for open and save file

================================================================================

You can do few steps with file before load or after save using BAT file

Example, copy file and compile it 

if %1 == -S (
  copy %2 %3
  compile %3
)

================================================================================
