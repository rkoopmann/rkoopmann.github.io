---
layout: post
title: reading iso dates and datetimes
category: sas
tags:
- datetime values
---

a while ago, i posted [a method of converting YYYYMMDD-style integers to sas date values](/sas/2007/12/converting-yyyymmdd). today, i needed to convert an YYYYMMDDHHMMSS-style integer to a sas date time value. i could have used the same method of conversion, but i though there had to be a better way. and there is.

<!--more-->

apparently, these are ISO 8601-style date and datetime formats. so why not use the iso-related formats and informats for date and datetime values?

to import a YYYYMMDD-style integer into a sas date value, i use the ND8601DA. informat and apply the date9. format. YYYYMMDDHHMMSS-style integer into a sas datetime value, one can use the ND8601DT. informat and apply the datetime19. format.

for more info than i care to provide, you can see the corresponding help pages for SAS [9.1.3](http://support.sas.com/onlinedoc/913/getDoc/en/engxml.hlp/a002766164.htm) and [9.2](http://support.sas.com/documentation/cdl/en/lrdict/61724/HTML/default/a003169665.htm).