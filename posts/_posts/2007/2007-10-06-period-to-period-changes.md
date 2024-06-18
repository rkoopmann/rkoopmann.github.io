---
layout: post
title: Calculating Period-to-Period Changes in SAS
author: rkoopmann
category: sas
tags:
- date values
- sas
- quatch
summary: calculating period-to-period changes with the lag function.
---

recently a co-worker asked me how to do period-to-period changes in proc tabulate. since i didn’t know of any procedural way to do this, i figured it can be done in the data step.

<!--more-->

    data example;
      format period yyq6. value 3.;
      input period:date9. value;
      change = dif(value)/lag(value);
    datalines;
    01oct2005 100
    01jan2006 120
    01apr2006 125
    01jul2006 120
    01oct2006 145
    01jan2007 150
    ;
    run;

the aggregated data set is probably going to be a proc means output data set. however you get to the aggregate dataset, adding the diff(value)/lag(value) will give you the relative change. to present this info in a fairly meaningful way, i use proc tabulate:

    proc tabulate data=example noseps;
      class period;
      var value change;
      table period=' ',
            value*sum=' '*f=8.
            change*sum=' '*f=percent8.1;
    run;

which produces this output:

|        | value |   change |
| :----- | ----: | -------: |
| 2005Q4 |   100 |        . |
| 2006Q1 |   120 |    20.0% |
| 2006Q2 |   125 |     4.2% |
| 2006Q3 |   120 | (  4.0%) |
| 2006Q4 |   145 |    20.8% |
| 2007Q1 |   150 |     3.4% |
