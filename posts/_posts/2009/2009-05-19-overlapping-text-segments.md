---
layout: post
title: reading overlapping text segments
category: sas
tags:
- sas
- web scraping
---

if you’re in the same boat as me, you’ve got sas 9.1.3 sp4 installed under windows. the thing about sas 9.1.3 sp4 running under windows is the lrecl is limited to 32,767 characters. (even though the [sas kb says 1mb](http://support.sas.com/kb/19/345.html), that doesn’t appear to be true. at least not for me.)

<!--more-->

if you’re trying to parse a long string of text (approaching 140,000 characters before a carriage return is encountered), things break.

here’s a nifty little trick for the input statement:

    data _null_;
      infile datalines;
      format seg $8.;
      input seg $8. @@ +(-2);
      put seg;
    datalines;
    abcdefghijklmnopqrstuvwxyz
    run;

so i read in 8 characters, back up 2 characters, read in 8 characters, back up 2 characters, …. the result is nice overlapping character segments ripe for parsing.

    1093  data _null_;
    1094    infile datalines;
    1095    format seg $8.;
    1096    input seg $8. @@ +(-2);
    1097    put seg;
    1098  datalines;

    abcdefgh
    ghijklmn
    mnopqrst
    stuvwxyz
    yz
    NOTE: SAS went to a new line when INPUT statement reached past the end of a line.
    NOTE: DATA statement used (Total process time):
          real time           0.00 seconds
          user cpu time       0.00 seconds
          system cpu time     0.00 seconds
          Memory                            151k


    1100  run;

the log shows something about sas reading over to the next line, but, whatever.

i may be missing something very obvious here. if you notice, would you please let me know in the comments.

this post is related to the [recent change](http://support.sas.com/training/forms/newdesign.html) to the [sas training course list](https://support.sas.com/edu/courses.html?ctry=us) which broke my [training parser](http://quatch.koopmann.us/post/2918939826/scraping-the-sas-training-pages).
