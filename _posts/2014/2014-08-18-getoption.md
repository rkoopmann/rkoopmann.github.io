---
layout: post
title: getOption
category: sas
tags:
- sas
- sas macro
- system options
date: 2014-08-18 15:32:47 -0500
---

SAS has a number of [system options](http://support.sas.com/documentation/cdl/en/lrdict/64316/HTML/default/viewer.htm#a000103941.htm) that we can access through dictionary tables (or sashelp v-tables) or with the built-in `getoption` function.

<!--more-->

For a given option, I'd like to be able to return the value through a macro call. Something like `line_width=%getOption(LINESIZE);`.

```
%macro getOption(optname);
%global getOption_value;
%let getOption_value=Specified option not found;
data _null_;
	call symput('getOption_value', getoption("&OPTNAME"));
run;
&getOption_value;
%mend;
```
