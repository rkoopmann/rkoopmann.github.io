---
layout: post
title: 'The Missing Format: QYY'
category: sas
tags:
- format
- sas
- quatch
---
sas has a lot of date-related formats…roman numerals, julian dates, jewish calendars, etc.

<!--more-->

today i came across the need to format dates by quarter similar to `yyq6.` (as in `2008Q3`), but instead `qyy6.` (as in `Q32008`). i needed to use the dates as variable names, so they have to start with a letter or underscore. since i was doing this in a transpose proc, i could’ve used the `prefix='_'` option, but that would’ve looked odd (`_2008Q3`).

so i decided to build a picture format. unfortunately, picture formats don’t have a quarter directive like they do for year, month, etc. so a homebrew method was in order.

    data qyyfmt;
        retain fmtname 'qyy';
        do y = 1995 to 2008;
            do q = 1 to 4;
                start=input(catx('q',y,q),yyq8.);
                end = intnx('qtr', start, 0, 'e');
                label = catt('Q',q,y);
                output;
            end;
        end;
    run;
    proc format cntlin=qyyfmt; run;

done. i could’ve expanded this to all feasible recent and future dates `do y = 1900 to 2099;`, but that's an overkill for my current need.
