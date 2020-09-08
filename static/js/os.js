//利用原生Js获取操作系统版本
function getOS() {
    var sUserAgent = navigator.userAgent;
    var isWin = (navigator.platform == "Win32") || (navigator.platform == "Windows");
    var isMac = (navigator.platform == "Mac68K") || (navigator.platform == "MacPPC") || (navigator.platform == "Macintosh") || (navigator.platform == "MacIntel");
    if (isMac) return "Mac";
    var isUnix = (navigator.platform == "X11") && !isWin && !isMac;
    if (isUnix) return "Unix";
    var isLinux = (String(navigator.platform).indexOf("Linux") > -1);
    if (isLinux) return "Linux";
    if (isWin) {
        var isWin2K = sUserAgent.indexOf("Windows NT 5.0") > -1 || sUserAgent.indexOf("Windows 2000") > -1;
        if (isWin2K) return "Win2000";
        var isWinXP = sUserAgent.indexOf("Windows NT 5.1") > -1 || sUserAgent.indexOf("Windows XP") > -1;
        if (isWinXP) return "WinXP";
        var isWin2003 = sUserAgent.indexOf("Windows NT 5.2") > -1 || sUserAgent.indexOf("Windows 2003") > -1;
        if (isWin2003) return "Win2003";
        var isWinVista= sUserAgent.indexOf("Windows NT 6.0") > -1 || sUserAgent.indexOf("Windows Vista") > -1;
        if (isWinVista) return "WinVista";
        var isWin7 = sUserAgent.indexOf("Windows NT 6.1") > -1 || sUserAgent.indexOf("Windows 7") > -1;
        if (isWin7) return "Win7";
        var isWin10 = sUserAgent.indexOf("Windows NT 10") > -1 || sUserAgent.indexOf("Windows 10") > -1;
        if (isWin10) return "Win10";
    }
    return "other";
}


/****获得客户端ID****/
function  ClientID (name) {
    var cookies = document.cookie.split(";");
    var value = "";
    for (var i = 0; i < cookies.length; i++) {
        var temp = cookies[i].split("=");
        var tempValue = temp[0].replace(/(^\s*)|(\s*$)/g, "");
        if (tempValue == name) {
            value = unescape(temp[1]);
            break;
        }
    }
    return value;
}

/**获得屏幕宽度**/
function ScreenWidth () {
    return window.screen.width;
};
/***获得屏幕高度**/
function ScreenHeight () {
    return window.screen.height;
};
/**获得浏览器***/
function Browse () {
    var browser = {};
    var userAgent = navigator.userAgent.toLowerCase();
    var s;
    (s = userAgent.match(/msie ([\d.]+)/)) ? browser.ie = s[1] : (s = userAgent.match(/firefox\/([\d.]+)/)) ? browser.firefox = s[1] : (s = userAgent.match(/chrome\/([\d.]+)/)) ? browser.chrome = s[1] : (s = userAgent.match(/opera.([\d.]+)/)) ? browser.opera = s[1] : (s = userAgent.match(/version\/([\d.]+).*safari/)) ? browser.safari = s[1] : 0;
    var version = "";
    if (browser.ie) {
        version = 'IE ' + browser.ie;
    }
    else {
        if (browser.firefox) {
            version = 'firefox ' + browser.firefox;
        }
        else {
            if (browser.chrome) {
                version = 'chrome ' + browser.chrome;
            }
            else {
                if (browser.opera) {
                    version = 'opera ' + browser.opera;
                }
                else {
                    if (browser.safari) {
                        version = 'safari ' + browser.safari;
                    }
                    else {
                        version = '未知浏览器';
                    }
                }
            }
        }
    }
    return version;
}