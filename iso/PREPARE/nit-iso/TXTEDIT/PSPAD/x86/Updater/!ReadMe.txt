PSPad editor Updater

Prerequisities:
Updater is placed in the PSPad subfolder with "Updater" name".
PSPad.exe must be presented in PSPad folder - updater must know PSPad version and platform 32b/64b  
Updater folder content required:
PSPUpdater.exe - main updater application
PSPUpdRun.exe - helper what helps to update updater, se behavior description bellow
libeay32.dll  (32b version of OpenSSL library)
ssleay32.dll  (32b version of OpenSSL library)
when you start updater manually from system folder (e.g. Program Files), you need to run it as admin

Optional:
excluded.txt
This file contains excluded files, e.g. your own modified templates
Each file on separate line without path
All listed files here will be ignored by updater 

Functionality:
updater helper makes copy of PSPUpdater.exe to _PSPUpdater.exe and run it 
updater downloads ZIP package from PSPad web and store it in TEMP folder
updater unpack ZIP package
updater deletes (if exists) content of BACKUP subfolder or create new empty folder
updater backups all files from downloaded ZIP into backup subfolder
updater replace existing files from downloaded ZIP
updater deletes TEMP files (downloaded ZIP and unpacked folder)
updater helper deletes _PSPUpdater.exe copy

You can update to current developer build or current full version
You can restore backup folder content

Important:
Each update cycle deletes backup folder and create new one.
When you update to full version and you do next update to developer version, 
you won't be able restore backup before update.
If you want to test versions, run restore backup before tests or make your own PSPad folder backup

Updater doesn't rewrite any user configuration file (PSPad.ini, PSpadFTP.ini, e.t.c.)

--------------------------------------------------------------------------------

Automatic update:

Updater is possible to run with parameters for automatic update:
-f or /f - update to last full versions
-d or /d - update to last developer build
-r or /r - restore from last backup
 
In this case Updater.log file is created in Updater folder 

ExitCodes:
0 - OK
1 - PSPad was running