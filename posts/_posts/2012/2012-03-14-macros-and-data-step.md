---
layout: post
title: Macros and the DATA Step
category: sas
tags:
- data step
- sas
- sas macro
---

recently, i had a need to use and update a macro variable *within* a data step. i wasn't certain about the timing of things, so i threw together a simple test.

<!--more-->

1. set a macro variable outside of a data step. (line 5742)
2. update the macro variable inside the data step. (line 5745)
3. use the (hopefully updated) macro variable to set a second variable within the data step. (line 5747)
4. put the value/calculation to the log window. (line 5748)

the log

    5742   %let x=5;
    5743   data _null_;
    5744       %put before symput: &x;
    before symput: 5
    5745       call symput('x',10);
    5746       %put after symput: &x;
    after symput: 5
    5747       xsquare=&X**2;
    5748       put xsquare;
    5749   run;


    NOTE: Numeric values have been converted to character values at the places given by: (Line):(Column).
        5745:21
    25
    NOTE: DATA statement used (Total process time):


    5750   %put outside data step: &x;
    outside data step:           10




i've peppered the thing with `%put` statements to check on the values throughout the execution. and it does exactly what i didn't want (line 5746). the data step used the **original** value rather than the updated value for the calculations.
