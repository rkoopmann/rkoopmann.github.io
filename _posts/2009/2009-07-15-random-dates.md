---
layout: post
title: random dates
category: sas
tags: 
- date values
- do loop
---

**this is a cross posting from [this sas discussion forum thread](http://support.sas.com/forums/thread.jspa?threadID=6436).**

<!--more-->

assuming you know the min and max of allowable dates (01jan2005 - 30jun2009, for example), you can use random functions.

    data randates;
        mindate='01jan2005'd;
        maxdate='30jun2009'd;
        range = maxdate-mindate+1;
        format mindate maxdate randate date9.;
        do i = 1 to 10000;
            RanDate = mindate + int(ranuni(12345)*range);
            output;
        end;
    run;

using this method, you don't need to find the number of days in a given month/year, SAS just knows.

a simple min/max check shows the date limits were respected

    proc sql;
        select distinct
            min(randate) format=date9.,
            max(randate) format=date9.
        from randates;
    quit;

output

    01JAN2005  30JUN2009