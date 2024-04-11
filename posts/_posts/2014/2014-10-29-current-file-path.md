---
layout: post
title: Current file path
category: sas
tags:
- snippet
- sas
link: http://stackoverflow.com/a/14416896/142229
---

Sometimes I need to reference the path of the current (saved) file. Thanks to [a stack overflow post](http://stackoverflow.com/a/14416896/142229), I can easily do that.

```
%let filepath=%substr(%sysget(SAS_EXECFILEPATH),1,
  %eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))));
%put &FILEPATH;
```
