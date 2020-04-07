---
layout: post
title: wiping usb drives
category: sas
tags:
- tip
---

before you give away that usb drive, you might want to wipe it clean. here's a short (in terms of lines) but long (in terms of execution time) program to do just that. before you start, go to my computer and determine the formatted capacity of the drive.

<!--more-->

delete everything on the drive, then run this program.

    data _null_;  
        file 'f:\junk.txt';  
        do m = 1 to 962; /* formatted capacity */  
            do k = 1 to 1024; /* 1024 kbs in a mb */  
                do b = 1 to 1024; /* 1024 bytes in a kb */  
                    put 'x' @;  
                end;  
            end;  
        end;  
    run;

it can take a while depending on your configuration. a 1GB drive took about 45 minutes to fill up.

next, delete the junk file and give it away.
