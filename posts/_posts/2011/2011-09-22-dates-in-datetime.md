---
layout: post
title: Dates in Datetime Fields
category: sas
tags:
- date values
- sas
---

Got date values intermingled with datetime values? Here's a brute force way to convert the date values into date time values.

<!--more-->

Code

    data _null_;
        x1='01JAN1960:05:09:56'dt;
        x2='12SEP2010:00:00:00'dt;
        array x(*) x:;
        do i = 1 to 2;
            if timepart(x[i]) then x[i]=dhms(x[i], 0, 0, 0);
            x[i] = datepart(x[i]);
        end;
        put x1 date.
        /   x2 date.;
    run;

Log

    30NOV10
    12SEP10

Note that if the date value is a product of 86400 (the number of seconds in a day), then timepart(date) will resolve to 0. Fortunately, the next time this will happen (after 01JAN1960) will be 21JUL2196.
