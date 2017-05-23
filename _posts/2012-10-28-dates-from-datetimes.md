---
layout: post
title: dates from date times
category: sas
tags:
- date values
- function
- technical debt
summary: input, substring, put or datepart. whichever, really.
---

Browsing online to find examples of creating a JSON file from a SAS data set I came across a monstrosity for extracting a date value from a date time value.

    end_dt=input(substr(put(s_end_dt,datetime20.),3,9),date9.);

I cringed and made a sound befitting of a good Halloween costume. Here's my typical approach for this:

    end_dt=datepart(s_end_dt);

Either way, I guess.
