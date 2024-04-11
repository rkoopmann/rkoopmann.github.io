---
layout: post
title: convert to a [hhmmss-type integer to a] sas time - (SO)
category: sas
tags:
- sas
- stack overflow
- time values
summary: converting time integers like `144500` into sas dates values like `2:45:00`.
link: http://stackoverflow.com/questions/16299643/convert-to-a-sas-time
---

A few years back, I posted a bit of sample code which converted [YYYYMMDD-type integers into proper SAS date values](/sas/converting-yyyymmdd/); it's been the most-viewed page since then. At the time, I thought about doing a HHMMSS-type-integer-to-proper-SAS-time-value as well, but I was in a hurry and, to be honest, never really dealt with time-sensitive data.

<!--more-->

Not much has changed, but [a recent post on SO](http://stackoverflow.com/questions/16299643/convert-to-a-sas-time) pushed my button, so here goes.

I took a slightly different (better?) approach since there were no obvious `HHMMSS.SSS` informats available (as [stevepastelan points out, `B8601TMw.d` would work](http://stackoverflow.com/a/16302507/142229)). Rather, I simply used the `PRXCHANGE` function to insert colons in the right spot (`161058.262 --> 16:10:58.262`), then used the `TIMEw.d` informat to get a proper SAS time value (`16:10:58.262 --> '4:10:58.2't`).

    data _null_;
        input int_val $10.;
        format time_val timeampm15.3;
        time_val = input(prxchange('s/(\d?\d)(\d\d)(\d\d\.\d\d\d)/$1:$2:$3/',-1, int_val), time10.3);
        put int_val
        @15 time_val timeampm15.3
        @30 time_val 10.3;
    datalines;
    000000.001
    012345.678
    12345.678
    161058.262
    235959.999
    run;

from the log:

    000000.001    12:00:00.000 AM     0.000
    012345.678     1:23:45.600 AM  5025.600
    12345.678      1:23:45.670 AM  5025.670
    161058.262     4:10:58.200 PM 58258.200
    235959.999    11:59:59.900 PM 86399.900

Note the leading 0 is optional for the 0-9 hours. Also, I'm not really sure what's going on with the dropped hundredths and thousandths of a second (possibly something with how SAS stores values?), but for my purposes, it works.
