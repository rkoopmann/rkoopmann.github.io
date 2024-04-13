---
layout: post
title: Pretty Note Blocks
subtitle: wherein i create a sas macro to facilitate making pretty note blocks for sas code
category: sas
tags:
- sas
- sas macro
summary: here is how i make sas comment blocks a little less jagged.
---

I like the idea of having nicely-aligned comment blocks, but dislike the task of having to manually break long lines and add in the trailing spaces needed to align the ending asterisk. i'm certain there's an OS X service which would allow me to do this automatically, but opted for a SAS macro to do it instead.

<!--more-->

```
%macro note(mSg, width=70);
    %let outter = %eval(&WIDTH - 1);
    %let inner = %eval(&WIDTH - 4);
    filename noteclip clipbrd;
    data _null_;
        file noteclip;
        format msg $5000.;
        msg="&MSG";
        put '/*' &INNER*'*' '*\';
        if length(msg) &gt; &INNER then
        do until (length(msg) le &INNER);
            tmpMsg = substr(msg,1,&INNER);
            break = findc(tmpMsg, , 'st', -&INNER);
            tmpMsg = sUbstr(msg,1,break);
            put '* ' tmpMsg @&OUTTER ' *';
            msg = left(substr(msg,break+1));
        end;
        put '* ' msg @&OUTTER ' *';
        put '\*' &INNER*'*' '*/;';
    run;
    filename noteclip clear;
%mend;
```

now, when i submit this:

```
%note(ABCD EFG HIJK LMNOP QRS TUV WX YZ abcd efg hijk lmnop qrs tuv wx yz ABCD EFG HIJK LMNOP QRS TUV WX YZ abcd efg hijk lmnop qrs tuv wx yz);
```

This is put on the clipboard:

```
/********************************************************************\
* ABCD EFG HIJK LMNOP QRS TUV WX YZ abcd efg hijk lmnop qrs tuv wx   *
* yz ABCD EFG HIJK LMNOP QRS TUV WX YZ abcd efg hijk lmnop qrs tuv   *
* wx yz                                                              *
\********************************************************************/;
```

and submitting this:

```
%note(%str(this is a somewhat lengdddthy note that the author would lik eto put ino the code, but really dislikes manually wrapping long lines across multiple, shorter lines. also, having that pretty asterisk at the end all lined up is pretty sweet. amiright), width=90);
```

my clipboard has this:

```
/****************************************************************************************\
* this is a somewhat lengdddthy note that the author would lik eto put ino the code,     *
* but really dislikes manually wrapping long lines across multiple, shorter lines.       *
* also, having that pretty asterisk at the end all lined up is pretty sweet. amiright    *
\****************************************************************************************/;
```
