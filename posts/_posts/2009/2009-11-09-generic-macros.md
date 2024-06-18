---
layout: post
title: The Utility of Generic Macros
category: sas
tags:
- sas
- sas macro
---

i've been using sas for roughly 5 years now. for the past few years, i've been building up my toolbox of what i call 'utility macros'. these are macros that are generic enough to be used in a wide variety of situations, but perform very specific, routine, and/or tedious tasks.

<!--more-->

these macros will very rarely produce the final product, but are quite useful in achieving that final state. these macros are in persistent development and various stages of stability. so examples may help?

one of my first macro utilities was to pull a dos directory listing into a sas data set for further processing. but i didn't just want a listing of filenames, i also wanted file sizes and dates of last modification. and as it turned out, recursive directory searching was a requirement. when i first started working on this macro, it was for my first SUGI (now SGF) submission, [Exploiting Consistent Program Documentation](http://www2.sas.com/proceedings/sugi31/150-31.pdf). this was basically a sas program to scrape and aggregate standard sas program headers. recently, i added the owner to the returned results.

another macro utility that i use on a regular basis results in exactly one thing, but it does so very elegantly: it returns a date formatted to your specifications. if you specify the desired format and it'll do it. since it’s a macro, it can be used in regular steps (data and proc) and in open code (the stuff that happens between data and proc steps). it can result in an absolute date or dynamic dates relative to some other known date (a macro variable like sysdate or user specified). it can also move in time (intnx function). recently, i modified the returned value to be LEFT aligned which involved UNQUOTE and QUOTE functions.

since i'm not the only person who uses some of these macros at my workplace, i wanted some way of tracking usage, most importantly how often a macro was being called, but also who was calling it. not to be big brother, mind you. rather, i was interested in determining which macros should be given my attention (when i find down time). but how to do this?

a utility macro to track utility macro use. i call that one tracker. but that's for another post.
