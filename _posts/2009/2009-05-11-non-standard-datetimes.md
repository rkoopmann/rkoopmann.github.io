---
layout: post
title: reading non-standard datetime values
category: sas
tags:
- datetime values
---

another datetime posting. this time, i needed to read in datetime values with the following format: `DD/MM/YYYY HH:MM:SS AM` where the leading zeros are optional for the day, month, and hour portion.

<!--more-->

since i couldn’t (quickly) locate an informat that is this flexible, it was time to parse. first order of business was to get the rogue datetime value into SAS in its current state:

	input x ? $50.;

next, i needed to break the string apart and use each portion as arguments for functions:

	dt=dhms(input(scan(x, 1, ' '), mmddyy10.),
	   0,
	   0,
	   input(catx(' ', scan(x, 2, ' '), scan(x, 3, ' ')), time.));

i could have used prx, but since my data set was small (obs < 2,500) and prx statements are somewhat beastly, i figured i'd use basic sas functions.

sample code can viewed below:
   
    data null;
      input x ? $50.;
      dt=dhms(input(scan(x, 1, ' '), mmddyy10.)
            , 0
            , 0
            , input(catx(' ', scan(x, 2, ' ')
            				, scan(x, 3, ' ')), time.)
            );
      put dt datetime19.;
    datalines;
    5/5/2009 2:22:17 AM
    04/08/2015 04:23:42 PM 
    run;