## Overview

This is a simple MQL4 wrapper that uses Windows native wininet.dll and
shell32.dll libraries and is supported by MT4 build 600 or newer.
Following features are currently supported:

- send HTTP requests (currently supported only GET method) to a remote
  destination and read the body response from MQL that was compiled in build 600
  and newer (not in a strict mode).

- open HTTP(S) URI in default system's web browser

## How to use

`mql4-http` is using system's dll libraries so make sure you enable DLL imports in
MT4 before running it (Tools -> Options -> Expert Advisors -> Allow DLL imports)

```c
#include <mql4-http.mqh>

int start () {

  string myIP = httpGET("http://icanhazip.com/");

  Print("My machine's IP is ", myIP);

  return(0);
}
```

In order to set timeout, use second argument (only "`n`s" format is supported):

```c
#include <mql4-http.mqh>

int start () {

  httpGET("http://example.com/long-running-task.php", "60s");

  return(0);
}
```

```c
#include <mql4-http.mqh>

int start () {

  httpOpen("http://example.com");

  return(0);
}
```

You can also [watch this video demonstration](http://screencast.com/t/UVMAlgCjJ2)

## Credits

This library was based on following great resources:

- HTTP Wininet sample: http://codebase.mql4.com/8115

- EasyXML parser: http://www.mql5.com/code/1998

## License

This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.

In jurisdictions that recognize copyright laws, the author or authors
of this software dedicate any and all copyright interest in the
software to the public domain. We make this dedication for the benefit
of the public at large and to the detriment of our heirs and
successors. We intend this dedication to be an overt act of
relinquishment in perpetuity of all present and future rights to this
software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

For more information, please refer to [<http://unlicense.org/>](http://unlicense.org)
