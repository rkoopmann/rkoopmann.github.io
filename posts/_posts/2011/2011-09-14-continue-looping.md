---
layout: post
title: continue-looping
category: sas
tags:
- do loop
- sas
---

if you've ever needed to stop processing a loop under certain conditions but pick back up with the next iteration of the loop, use the continue statement.

    data _null_;
        do i = 1 to 3;
            do j = 1 to 3;
                if i=j then continue;
                put i j;
            end;
        end;
    run;

the log

    1 2
    1 3
    2 1
    2 3
    3 1
    3 2
