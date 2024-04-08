---
layout: post
title: The Ugly Truth About Call Execute
category: sas
tags:
- sas
- sas macro
---

let's start off with a simple macro that spits out some text and the value of a variable:

    %macro ex(text,var);
        %put &text &var;
    %mend;

<!--more-->

now let's try to execute the macro twice, once in a `call execute` statement ('in call' at line 353) and then in a regular stand-alone version ('regular' at line 354):

    351  data _null_;
    352      x = 3;
    353      call execute('%ex(in call,'|| x || ')');
    354      %ex(regular, x);
    regular x
    355  run;

    NOTE: Numeric values have been converted to character values at the places given by: (Line):(Column).
          353:33
    in call 3
    NOTE: DATA statement used (Total process time):
          real time           0.00 seconds
          user cpu time       0.00 seconds
          system cpu time     0.00 seconds
          Memory                            135k

    NOTE: CALL EXECUTE routine executed successfully, but no SAS statements were generated.

notice the placement of the two different macro executions? the `call execute` macro statement was executed after the data step finished while the regular macro statement was executed within the data step. interesting, don't you think?

it gets better. let's look at how these two beasts behave in a loop:

    356  data _null_;
    357      do x = 1 to 3;
    358          call execute('%ex(in call,'|| x || ')');
    359          %ex(regular, x);
    regular x
    360      end;
    361  run;

    NOTE: Numeric values have been converted to character values at the places given by: (Line):(Column).
          358:35
    in call 1
    in call 2
    in call 3
    NOTE: DATA statement used (Total process time):
          real time           0.01 seconds
          user cpu time       0.00 seconds
          system cpu time     0.00 seconds
          Memory                            135k

	NOTE: CALL EXECUTE routine executed successfully, but no SAS statements were generated.

now it seems that the regular macro statement executes in place, but only once even though it is inside a loop. the call execute macro statement executes post-data step three times as expected.

the [`call execute` documentation](http://support.sas.com/91doc/getDoc/mcrolref.hlp/a000543697.htm#a000543698) explains:

> If an EXECUTE routine argument is a macro invocation or resolves to one, the macro executes immediately. However, any SAS statements produced by the EXECUTE routine do not execute until after the step boundary has been passed.

if you're not expecting it, this behavior can definitely throw you for a loop.
