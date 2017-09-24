---
layout: post
title: month of quarter variable
category: sas
tags:
- date values
- format
---

quick formula to calculate the month of the quarter (JAN, APR, JUL, OCT=1; FEB, MAY, AUG, NOV=2; MAR, JUN, SEP, DEC=3). moq=mod(month(date- value)-1,3)+1; note this is completely poached from an old excel formula.

<!--more-->

here's the formula in action:

    data _null_;
        do y = 2009 to 2010;
            do m = 1 to 12;
                d=mdy(m,1,y);               * make a date variable;
                moq=mod(month(d)-1,3)+1;    * make Month Of Quarter variable;
                put d date9. +5 moq;        * put to log;
            end;
        end;
    run;

from the log

    01JAN2009     1
    01FEB2009     2
    01MAR2009     3
    01APR2009     1
    01MAY2009     2
    01JUN2009     3
    01JUL2009     1
    01AUG2009     2
    01SEP2009     3
    01OCT2009     1
    01NOV2009     2
    01DEC2009     3
    01JAN2010     1
    01FEB2010     2
    01MAR2010     3
    01APR2010     1
    01MAY2010     2
    01JUN2010     3
    01JUL2010     1
    01AUG2010     2
    01SEP2010     3
    01OCT2010     1
    01NOV2010     2
    01DEC2010     3
