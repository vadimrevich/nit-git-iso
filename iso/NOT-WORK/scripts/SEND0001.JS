/**********************************************************
 * SEND0001.js  - Send a Message with a Support Request
**********************************************************/

function getIPAddress(passedInt) {
    var NIC1, nic, StrIP, ipMessage, SQLQuery, strComputer, colItems, locator;
    SQLQuery = "SELECT * FROM Win32_NetworkAdapterConfiguration WHERE     MACAddress > '' AND IPEnabled = 'True'";
    strComputer = ".";
    locator = new ActiveXObject("WbemScripting.SWbemLocator");
    NIC1 = locator.ConnectServer(strComputer, "root\\cimv2");
    colItems = NIC1.ExecQuery(SQLQuery);
    StrIP = "";
    for( nic in colItems ){
        if( nic.IPAddress.isArray())
        {
            if (nic.IPAddress.ubound(1) == 0) {
                StrIP = nic.IPAddress[0];
            }
            else {
                StrIP += nic.IPAddress.join(",");
            }
        }
    };
    // WScript.Echo("IP = " + StrIP);
    ipMessage = StrIP.split(",");
    return ipMessage[passedInt];
}

 function send() {

    var wsh;
    wsh = new ActiveXObject("Wscript.Shell");
    var objEnv = wsh.Environment("Process");
    var strComputer = objEnv("COMPUTERNAME");
    var strUser = objEnv("USERNAME");
    var recpt = "vadimrevich21@gmail.com";
    var subj = "A%20letter%20from%20" + strUser + "%20" + strComputer +"%20with%20support%20request";
    var text = "Hello%21%0A%3C%D0%9F%D0%BE%D0%B6%D0%B0%D0%BB%D1%83%D0%B9%D1%81%D1%82%D0%B0%2C%20%D0%B2%D0%B2%D0%B5%D0%B4%D0%B8%D1%82%D0%B5%20%D1%81%D1%8E%D0%B4%D0%B0%20%D1%81%D0%B2%D0%BE%D1%91%20%D0%B8%D0%BC%D1%8F%2C%20%D0%B0%D0%B4%D1%80%D0%B5%D1%81%20%D0%B4%D0%BB%D1%8F%20%D1%81%D0%B2%D1%8F%D0%B7%D0%B8%20%D0%B8%20%D1%82%D0%B5%D0%BA%D1%81%D1%82%20%D1%81%D0%BE%D0%BE%D0%B1%D1%89%D0%B5%D0%BD%D0%B8%D1%8F%3E%0A";
    // text += "%0A%0A" + getIPAddress(0) + "%0A%0A";
    var bcc = "smirnoff-ass-macho@yandex.ru";

    // Get a Content
    // var content="mailto:"+recpt+"?subject="+subj+"&body="+text+"&bcc="+bcc;
    var content="mailto:"+recpt+"?subject="+subj+"&body="+text;
    // window.location = content

    // Run a Content
    wsh.Run(content, 2, false);

 }

send()
