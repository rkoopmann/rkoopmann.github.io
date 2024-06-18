---
layout: post
title: An mmddyyyy hhmmss Informat. Kinda.
category: sas
tags:
- date values
- informats
- sas
- quatch
---

[a while ago](http://quatch.koopmann.us/post/2918942598/reading-non-standard-datetime-values), i took the hack shortcut of reading character datetime stamps into datetime values. i even went so far as suggesting a regex would be a better solution.

<!--more-->

well, here’s that better solution:

```
data mmddyyyy_hhmmss_xm;
    if _n_=1 then do;
    re=prxparse('/(\d+)\/(\d+)\/(\d\d\d\d)\s+(\d+):(\d\d):(\d\d)\s+([AP]M)/');
    retain re;
    end;

    infile datalines; input; _sdt=_infile_;

    format dt datetime19.;

    array _s(*) _sdt;
    array _d(*) dt;
    do i = 1 to dim(_s);
    if prxmatch(re, _s[i]) then
    _d[i]=dhms(mdy(input(prxposn(re,1,_s[i]),2.) /*month*/
                ,input(prxposn(re,2,_s[i]),2.)   /*day*/
                ,input(prxposn(re,3,_s[i]),4.)   /*year*/)
            ,input(prxposn(re,4,_s[i]),2.)       /*hour*/
             + 12*(prxposn(re,7,_s[i]) eq 'PM')  /*pm offset*/
            ,input(prxposn(re,5,_s[i]),2.)       /*minute*/
            ,input(prxposn(re,6,_s[i]),2.)       /*second*/);
    end;
    output;
    drop re i;
datalines;
9/21/2009         10:02:42          PM
10/01/2009 9:44:37 AM
1/1/2009    12:13:14 AM
run;
```

and the output

```
_sdt                                                       dt
9/21/2009         10:02:42          PM     21SEP2009:22:02:42
10/01/2009 9:44:37 AM                      01OCT2009:09:44:37
1/1/2009    12:13:14 AM                    01JAN2009:12:13:14
```
