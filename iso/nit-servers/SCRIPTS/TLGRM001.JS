/**********************************************************
 * WTSAP001.js  - Send a Message with a Support Request
 * This Script will Send a Telegram Message with Support 
 * Request to NIT User
 *
 * The Function will Use Standard Telegram Client for Sending
 * a Letter withh Normal Privileges. If default Telegram or
 * Web Client is not Set, the Letter is not Sent.
**********************************************************/

 function send() {

    var wsh;
    wsh = new ActiveXObject("Wscript.Shell");
    var objEnv = wsh.Environment("Process");
    var strComputer = objEnv("COMPUTERNAME");
    var strUser = objEnv("USERNAME");
    var recpt = "yxzs1969";
    var subj = "A%20message%20from%20" + strUser + "%20" + strComputer +"%20with%20support%20request";
    
    // Get a Content
    // var content="mailto:"+recpt+"?subject="+subj+"&body="+text+"&bcc="+bcc;
    var content="https://t.me/"+recpt;
    // window.location = content

    // Run a Content
    wsh.Run(content, 2, false);
 }

send()
