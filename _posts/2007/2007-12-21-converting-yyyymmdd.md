---
layout: post
title: Converting YYYYMMDD-Type Integer to SAS Date Values
author: rkoopmann
category: sas
summary: converting integer dates like `20071221` to sas dates like `21DEC2007`.
tags:
- sas
- date values
---

if you've got date keys (e.g., `20071221`) that you need to convert to sas date values (`21DEC2007`), you may run into some troubles.

<!--more-->

you might be tempted to simply use an informat to read in the integer value as a date value. for example, `input(int_val, yymmdd8.)`. but your log will get peppered with error notes:

	NOTE: Invalid argument to function INPUT at line xxx column yyy.

the trick is to first convert the numeric value into a character value then back to a numeric value with a date informat.

input program

    data _null_;
        input int_val;
        date_val = input(put(int_val, 8.), yymmdd8.);
        put int_val
        @10 date_val date9.
        @20 date_val 6.;
    datalines;
    20071221
    19600102
    19600101
    19591231
    run;

log snippet

    20071221 21DEC2007  17521
    19600102 02JAN1960      1
    19600101 01JAN1960      0
    19591231 31DEC1959     -1
