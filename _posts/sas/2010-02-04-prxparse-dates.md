---
layout: post
title: prxparse(dates)
category: sas
tags:
- prx
- date values
---

i’ve got some odd character dates that i need to fix. here's some examples:

    d1='29-31 DEC 2009,04-05 JAN 2010'; *broken across month, year;
    d2='04-05,08-09,11-12 FEB 2010';    *broken within month;
    d3='01-03 MAR 2010';                *contiguous within month;
    d4='31 MAR-01 APR 2010';            *contiguous across month;
    d5='29 DEC 2009-01 JAN 2010';       *contiguous across year;
    d6='01 FEB 2010';                   *single day;

<!--more-->

trying to query based on dates would be next to impossible. so, prx those things.

    Original: >>>29-31 DEC 2009,04-05 JAN 2010<<<
    sd=29 sm=DEC sy=2009 sdate=29DEC2009
    ed=05 em=JAN ey=2010 edate=05JAN2010

    Original: >>>04-05,08-09,11-12 FEB 2010<<<
    sd=04 sm=FEB sy=2010 sdate=04FEB2010
    ed=12 em=FEB ey=2010 edate=12FEB2010

    Original: >>>01-03 MAR 2010<<<
    sd=01 sm=MAR sy=2010 sdate=01MAR2010
    ed=03 em=MAR ey=2010 edate=03MAR2010

    Original: >>>31 MAR-01 APR 2010<<<
    sd=31 sm=MAR sy=2010 sdate=31MAR2010
    ed=01 em=APR ey=2010 edate=01APR2010

    Original: >>>29 DEC 2009-01 JAN 2010<<<
    sd=29 sm=DEC sy=2009 sdate=29DEC2009
    ed=01 em=JAN ey=2010 edate=01JAN2010

    Original: >>>01 FEB 2010<<<
    sd=  sm=  sy=  sdate=01FEB2010
    ed=  em=  ey=  edate=01FEB2010

full code lives [here](https://github.com/rkoopmann/sas-quatch/blob/master/google-code-files/dates.sas).