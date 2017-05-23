---
layout: post
title: finding conventions, establishing standards
author: rkoopmann
category: sas
tags:
- perl
drafted: 2014-08-26 17:00:00 -0500
date: 2014-08-26 22:52:37 -0500
---

I'm creating a perl script that reads through all `.sas` files in a directory taking note when a SAS macro is being defined.

<!--more-->

I'm in a rut right now trying to figure out how to 

```
%* in SAS, macros can be defined a few different ways;

%macro regular(param1);
%mend;

%macro withDescription / des='bah';
%mend;

%macro emptyOptions () ;
%mend;

%macro noOptions;%mend;

%macro spacedOut (
  bah=ram
) / some options;
%mend;

%macro noSpace(a,b=c,d=e)/des='something';
%mend;

%macro outside;
	%macro inside;
	%mend;
%mend;
```

I've developed some perl code to index these macros.

```perl
%macro\s+(\w+)\s*\(??(.*?)\)??\s*/?\.*;
(%macro\s.+?;) ## capture macro statement
%macro\s*(\w+)\s*(\(\s*.+?\s*\))??; ## capture macro name & paren with contents
```