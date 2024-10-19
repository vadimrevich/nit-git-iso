/**********************************************************
 * WTSAP001.js  - Send a Message with a Support Request
 * This Script will Send a WhatsApp Message with Support 
 * Request to NIT User
 *
 * The Function will Use Standard E-mail Client for Sending
 * a Letter withh Normal Privileges. If default WhatsApp or
 * Web Client is not Set, the Letter is not Sent.
**********************************************************/

 function send() {

    var wsh;
    wsh = new ActiveXObject("Wscript.Shell");
    var objEnv = wsh.Environment("Process");
    var strComputer = objEnv("COMPUTERNAME");
    var strUser = objEnv("USERNAME");
    var recpt = "79047071125";
    // var recpt = "79173171027";
    var subj = "A%20message%20from%20" + strUser + "%20" + strComputer +"%20with%20support%20request";
    
    // Get a Content
    // var content="mailto:"+recpt+"?subject="+subj+"&body="+text+"&bcc="+bcc;
    var content="https://api.whatsapp.com/send/?phone="+recpt+"&text="+subj + "&web=1&app_absent=1";
    // window.location = content

    // Run a Content
    wsh.Run(content, 2, false);
 }

send()
