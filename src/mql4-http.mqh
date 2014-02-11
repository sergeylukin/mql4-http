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

#import "wininet.dll"
int InternetOpenW(
    string     sAgent,
    int        lAccessType,
    string     sProxyName="",
    string     sProxyBypass="",
    int     lFlags=0
);
int InternetOpenUrlW(
    int     hInternetSession,
    string     sUrl, 
    string     sHeaders="",
    int     lHeadersLength=0,
    int     lFlags=0,
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

string httpGET(string strUrl)
{
   int handler = hSession(false);
   int response = InternetOpenUrlW(handler, strUrl);
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
