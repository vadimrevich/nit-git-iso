/*
 *	FILENAME   		: any_tag_close.js
 *	DESCRIPTION		: PSPad WSH Extension. 
 *					  Automatic closing HTML, XML, XLS and any arbitrary tags
 *	VERSION			: 1.7.1 
 *	PSPAD VERSION	: 2.5.5 (2386) Tested 
 *	CREATED    		: 08.10.2006 - 17.10.2006
 *	CREATED BY		: Serge Balance
 *	MODIFIED		: 02.04.2010
 *	MODIFIED BY		: Anton Ivanov aka karminski
 *					  anton.p.ivanov@gmail.com
 *	
 *	COPYRIGHT (C), 2006 Serge Balance, 2010 Anton Ivanov
 *	Provided under the MIT License
 *	www.opensource.org/licenses/mit-license.php
 *	 
 *	VERSION HISTORY 
 *	
 *  1.7.1 (02.04.2010)
 *	* Fixed: Instead of placing the close tag at the right position, it is 
 *	  placed at the beginning of the line.
 *	     
 */


var module_name  = "Autoclosing TAG";
var module_ver   = "1.7.1";
var module_title = "Automatic closing html, xml, xsl and any arbitrary tag";
function Init() {
    menuName = "&" + module_name;
    subMenu = "&" + "web";
    addMenuItem(menuName, subMenu, "main", "CTRL+.");
}

var htmlTAGsingle = new Array(
	"area", "base", "basefont", "br", "col", "frame", "hr", "img", "input", 
	"isindex", "link", "meta", "param"
);

var htmlTAGpair = new Array(
	"a", "abbr", "acronym", "address", "applet", "area", "b", "bdo", "big", 
	"blink", "blockquote", "body", "button", "caption", "center", "cite", 
	"code", "colgroup", "dd", "del", "dfn", "dir", "div", "dl", "dt", "em", 
	"fieldset", "object", "font", "form", "textarea", "frameset", "noframes", 
	"frameset", "html", "form", "h1", "h2", "h3", "h4", "h5", "h6", "head", 
	"style", "i", "iframe", "ilayer", "ins", "kbd", "label", "layer", "legend", 
	"li", "listing", "map", "marquee", "menu", "script", "multicol", "nobr", 
	"noembed", "nolayer", "noscript", "object", "ol", "optgroup", "option", "p",
	"pre", "q", "s", "samp", "select", "server", "small", "span", "strike", 
	"strong", "sub", "sup", "table", "td", "tr", "div", "tbody", "tfoot", "th", 
	"thead", "textarea", "title", "tt", "u", "ul", "var", "comment", "xml", 
	"xmp"
);

function main() {
	var	ed = neweditor();
	ed.assignActiveEditor();
	var text = new String(ed.text());
	var curx = ed.caretX();
	var cury = ed.caretY();
	var cursymb, i, pos, postest, posopen;
	var insString = new String();
	var stk = new Array();
	var stkpop = new String();
	var tagName = new String();

	pos = indexInText(text, curx, cury); //index correction counted in indexInText
	postest = pos - 1; // - 1 for search not from current position
	insString = "";
	while ((posopen = text.lastIndexOf("<",postest)) != -1) {
		cursymb = text.substring(posopen,postest+1);
		if (text.charAt(posopen+1) != "/") {
			tagName = matchOpenTagName(cursymb);
			if ((tagName != null) && (isSingleTag(cursymb, tagName, htmlTAGsingle) == false)) {
				if (stk.length > 0) {
					stkpop = stk.pop();
					if (tagName != stkpop) {
						incorrect_html(stkpop, "left");
						return (-1); // with incorect html we don't working
					}
				} else {
					insString = "</" + tagName + ">";
				}
			}
		} else { //building stack closed tags
			tagName = matchCloseTagName(cursymb);
			if (tagName != null) { stk.push(tagName); } // if null - broken tag
		}
		if (insString != "") { break };
		postest = posopen - 1;
		if (postest <= 0) { break; }
	}
	if (insString != "") {
	postest = pos;
	var closed = false; //check may be first unpair tag from left already closed on right
		while ((posopen = text.indexOf("<",postest)) != -1) {
			cursymb = text.substring(posopen,text.length);
			if (text.charAt(posopen+1) == "/") {
				tagName = matchCloseTagName(cursymb);
				if (stk.length > 0) {
					stkpop = stk.pop()
					if ((tagName == null) || (tagName != stkpop)) {
						incorrect_html(stkpop, "right");
						return (-1); // with incorect html we don't working
					}
				} else {
				if ((tagName != null) && ("</"+tagName+">" == insString)) {
					closed = true;
				}
				break; // if first unpair closing tag at right not our - it's OK!
				}
			} else { //building stack opened tags
				tagName = matchOpenTagName(cursymb);
				if ((tagName != null) && (isSingleTag(cursymb, tagName, htmlTAGsingle) == false)) {
					stk.push(tagName);
				} // if null - broken tag
			}
			postest = posopen + 1;
			if (postest >= text.length) { break; }
		}
		if (closed) {
			echo("Tag already closed!");
			return (-1);
		} else {
			/* This block is modified by karminski, 02.04.2010 -- */
			ed.command('ecLineBreak');
			ed.command('ecLineBreak');
			ed.command('ecUp');
			ed.lineText(insString);
			ed.command('ecLineEnd');
			ed.command('ecDeleteChar');
			ed.command('ecLineStart');
			ed.command('ecDeleteLastChar');
			ed.setCaretPos(curx + insString.length, cury);
			return (0);
			/* -- End modified block */
		}
	} else {
		echo("Open tag not found!");
		return (-1);
	}
}

function indexInText(text, curx, cury) { 
	// function for lib WSH-PSPad
	// calculate linear coordinate in String text, based on cursor coordinates 
	var i = 1; // from first line, not zero
	var pos = 0;
	var cursymb = new String();
	while (i < cury) {
		pos = text.indexOf("\n",pos);
		pos++; // next search from next position
		i++;
	}
	cursymb = text.charAt(pos);
	if ((cursymb == "\n") || (cursymb == "\r") || (cursymb == "\f")) {
		pos++;
	}
	pos = pos + curx - 1; // Array index from 0, string index from 1
	return (pos);
}

function matchXMLsingleTagName(str) {
	return(((str.match(/^<([a-zA-Z_0-9:\-]+)(?:\s*|\s+(?:"[^"]*"|'[^']*'|[^'">])*)\/>/i)) != null) ? RegExp.$1 : null);
}

function matchOpenTagName(str) {
	return(((str.match(/^<([a-zA-Z_0-9:\-]+)[\s>]/i)) != null) ? RegExp.$1 : null);
}

function matchCloseTagName(str) {
	return(((str.match(/^<\/([a-zA-Z_0-9:\-]+)>/i)) != null) ? RegExp.$1 : null);
}

function isSingleTag(str, tagName, htmlTAGsingle) {
 	// At first test single html tag
	if (isInArray(tagName, htmlTAGsingle) != -1) {
		return true;
	}
	
	//Correctly xml-closed single tag testing fast
	if (matchXMLsingleTagName(str) != null) {
		//Not correctly closed xml tag with attributes can slow down script for some time!
		return true;
	}		
	return false;
}

function isInArray (str, arra) {
	var i;
	for (i in arra) {
		if (str == arra[i]) {
			return i;
		}
	}
	return -1;
}

function incorrect_html(stkpop, side) {
	echo("Incorrect html! See <" + stkpop + "> on the " + side + " from cursor");
	return (0);
}