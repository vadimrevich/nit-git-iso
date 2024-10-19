' it will print all open files to printer
const module_name  = "PrintAll"         'this name must be unique !!!
const module_ver   = "0.001a"            'version

sub PrintAll
  set obj = NewEditor()
  for i = 0 to editorsCount - 1
      obj.assignEditorByIndex(i)
      if i = 0 then     'for first file we call printer settings dialog
         obj.printFile(True)
      else              'all other files will be printed to selected printer
         obj.printFile(False)
      end if
  next  
end sub

sub ConvertAll
  set obj = NewEditor()
  for i = 0 to editorsCount - 1
      obj.assignEditorByIndex(i)
      obj.activate()
      sleep(100)
      if i = 0 then     'for first file we call printer settings dialog
         runPSPadAction("aUserConvertors")
      else              'all other files will be printed to selected printer
         runPSPadAction("aLastUserConvertor")
      end if
  next  
end sub

sub NamesToClipbrd
  set obj = NewEditor()
  s = ""
  for i = 0 to editorsCount - 1
      obj.assignEditorByIndex(i)
      s = s & obj.fileName & vbNewLine
  next  
  setClipboardText(s)
end sub

sub RemoveDuplicitiesCS
  set obj = NewEditor()
  for i = 0 to editorsCount - 1
      obj.assignEditorByIndex(i)
      obj.activate()
      sleep(100)
      runPSPadAction("aRemoveDuplicities")
  next  
end sub

sub RemoveDuplicitiesCI
  set obj = NewEditor()
  for i = 0 to editorsCount - 1
      obj.assignEditorByIndex(i)
      obj.activate()
      sleep(100)
      runPSPadAction("aRemoveDuplicitiesCI")
  next  
end sub

sub FileFormatDos
  set obj = NewEditor()
  for i = 0 to editorsCount - 1
      obj.assignEditorByIndex(i)
      obj.activate()
      sleep(100)
      runPSPadAction("aDosFormat")
  next  
end sub

sub FileFormatMac
  set obj = NewEditor()
  for i = 0 to editorsCount - 1
      obj.assignEditorByIndex(i)
      obj.activate()
      sleep(100)
      runPSPadAction("aMacFormat")
  next  
end sub

sub FileFormatUnix
  set obj = NewEditor()
  for i = 0 to editorsCount - 1
      obj.assignEditorByIndex(i)
      obj.activate()
      sleep(100)
      runPSPadAction("aUnixFormat")
  next  
end sub

' name "Init" is required, its called automatically during initialization to create menu items
sub Init
  addMenuItem "&Print all files","All open files", "PrintAll"
  addMenuItem "User &convert all files","All open files", "ConvertAll"
  addMenuItem "&List of open files to clipboard","All open files", "NamesToClipbrd"
  addMenuItem "&Remove duplicities case sensitive","All open files", "RemoveDuplicitiesCS"
  addMenuItem "R&emove duplicities case insensitive","All open files", "RemoveDuplicitiesCI"
  addMenuItem "Change file format to &DOS (Cr+Lf)","All open files", "FileFormatDos"
  addMenuItem "Change file format to &MAC (Cr)","All open files", "FileFormatMac"
  addMenuItem "Change file format to &UNIX (Lf)","All open files", "FileFormatUnix"
end sub
