var ready = false;
var embed = false;

function ThisMovie(movieName){
    if (navigator.appName.indexOf("Microsoft") != -1) {
         return window[movieName];
     } else {
         return document[movieName];
     }
}

function SendToActionScript(movieName, whichFunction, whichValue) {
    ThisMovie(movieName)[whichFunction](whichValue);
}


function IsIE() {
    if (window.ActiveXObject) {
        // IE
        return true;
    }
    else {
        // Firefox
        return false;
    }
}

function getFlash() {
    if (IsIE())
        return window.document.getElementById('FlashObjectIE');
    else
        return window.document.getElementById('FlashObjectFF');

}


function setReady()
{
    ready = true;
}

function resetReady()
{
    ready = false;
}

function setEmbed()
{
    embed = true;
}

function resetEmbed()
{
    embed = false;
}

