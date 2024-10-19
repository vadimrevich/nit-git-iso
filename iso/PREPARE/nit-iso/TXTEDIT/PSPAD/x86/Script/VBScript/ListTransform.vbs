' it will print all open files to printer
const module_name  = "ListTransform"
const module_ver   = "1.1"          

sub ListString
	dim item, s
  set obj = NewEditor()
  obj.assignActiveEditor()
  s = ""
  for each item in obj
	if Trim(Item) <> "" then
        s = s & "'" & Trim(item) & "', "
    end if    
  next
  s = "(" & Left(s, len(s)-2) & ")"
  obj.command("ecSelectAll")
  obj.selText(s)
  setClipboardText(s)
end sub

sub ListItems
	dim item, s
  set obj = NewEditor()
  obj.assignActiveEditor()
  s = ""
  for each item in obj
	if Trim(Item) <> "" then
        s = s & Trim(item) & ", "
    end if    
  next
  s = "(" & Left(s, len(s)-2) & ")"
  obj.command("ecSelectAll")
  obj.selText(s)
  setClipboardText(s)
end sub

sub LineToList
  dim s	
  set obj = NewEditor()
  obj.assignActiveEditor()
  obj.command("ecSelectAll")
  s = Trim(obj.selText())
  if Left(s, 1) = "(" then
  	s = Mid(s, 2)
  end if
  if Right(s, 1) = 	")" then
  	s =  Left(s, Len(s) - 1)
  end if
  a = split(s, ",")
  s = ""
  for each x in a
  	x = Trim(x)
	if left(x, 1) = "'" then
		x = Mid(x, 2, Len(x) - 2)
	end if
 	s = s & x & Chr(13) & chr(10)
  next  
  obj.selText(s)
end sub  
    

' name "Init" is required, its called automatically during initialization to create menu items
sub Init
  addMenuItem "&1. List of strings","List conversion", "ListString", "Shift+Ctrl+H"
  addMenuItem "&2. List of items","List conversion", "ListItems", "Shift+Ctrl+J"
  addMenuItem "&3. Line to list","List conversion", "LineToList", "Shift+Ctrl+L"
end sub
