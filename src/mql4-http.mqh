//+----------------------------------------------------------------------------+
//|                                                              mql4-http.mqh |
//+----------------------------------------------------------------------------+
//|                                                      Built by Sergey Lukin |
//|                                                    contact@sergeylukin.com |
//|                                                                            |
//| This libarry is highly based on following:                                 |
//|                                                                            |
//| - HTTP Wininet sample: http://codebase.mql4.com/8115                       |
//| - EasyXML parser: http://www.mql5.com/code/1998                            |
//|                                                                            |
//+----------------------------------------------------------------------------+

#import "shell32.dll"
int ShellExecuteW(
    int hwnd,
    string Operation,
    string File,
    string Parameters,
    string Directory,
    int ShowCmd
);
#import

#import "wininet.dll"
int InternetOpenW(
    string     sAgent,
    int        lAccessType,
    string     sProxyName="",
    string     sProxyBypass="",
    int     lFlags=0
);
int InternetSetOptionW(
    int        hInternet,
    int        dwOption,
    int   &    lpBuffer[],
    int        dwBufferLength
);
int InternetOpenUrlW(
    int     hInternetSession,
    string     sUrl, 
    string     sHeaders="",
    int     lHeadersLength=0,
    uint     lFlags=0,
    int     lContext=0 
);
int InternetReadFile(
    int     hFile,
    uchar  &   sBuffer[],
    int     lNumBytesToRead,
    int&     lNumberOfBytesRead
);
int InternetCloseHandle(
    int     hInet
);       
#import

#define INTERNET_FLAG_RELOAD            0x80000000
#define INTERNET_FLAG_NO_CACHE_WRITE    0x04000000
#define INTERNET_FLAG_PRAGMA_NOCACHE    0x00000100
#define INTERNET_OPTION_CONNECT_TIMEOUT 2

int hSession_IEType;
int hSession_Direct;
int Internet_Open_Type_Preconfig = 0;
int Internet_Open_Type_Direct = 1;

int hSession(bool Direct)
{
    string InternetAgent = "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; Q312461)";
    
    if (Direct) 
    { 
        if (hSession_Direct == 0)
        {
            hSession_Direct = InternetOpenW(InternetAgent, Internet_Open_Type_Direct, "0", "0", 0);
        }
        
        return(hSession_Direct); 
    }
    else 
    {
        if (hSession_IEType == 0)
        {
           hSession_IEType = InternetOpenW(InternetAgent, Internet_Open_Type_Preconfig, "0", "0", 0);
        }
        
        return(hSession_IEType); 
    }
}

string httpGET(string strUrl, string timeoutInSeconds = "")
{
   int handler = hSession(false);
   if (timeoutInSeconds != "")
   {
       int timeout=StrToInteger(timeoutInSeconds) * 1000;
       int option[] = {0};
       option[0] = timeout;
       InternetSetOptionW(handler,
                          INTERNET_OPTION_CONNECT_TIMEOUT,
                          option, 4);
   }

   int response = InternetOpenUrlW(handler, strUrl, NULL, 0,
        INTERNET_FLAG_NO_CACHE_WRITE |
        INTERNET_FLAG_PRAGMA_NOCACHE |
        INTERNET_FLAG_RELOAD, 0);
   if (response == 0) 
        return(false);
        
   uchar ch[100]; string toStr=""; int dwBytes, h=-1;
   while(InternetReadFile(response, ch, 100, dwBytes)) 
  {
    if (dwBytes<=0) break; toStr=toStr+CharArrayToString(ch, 0, dwBytes);
  }
  
  InternetCloseHandle(response);
  return toStr;
}

void httpOpen(string strUrl)
{
  Shell32::ShellExecuteW(0, "open", strUrl, "", "", 3);
}
