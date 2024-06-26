---
layout: post
title: Getting Feedback on Macro Parameters
category: sas
tags:
- sas
- sas macro
- tip
---

adding the following code inside a macro:

```
%local macro; %let macro=&amp;SYSMACRONAME;
*** spit out the parameter keys and values to the log ***;
%put ***********************************************************************************;
%put Parameter values to be used by &amp;SYSMACRONAME are:;
%put _local_;
%put ***********************************************************************************;
```

will spit out some useful information in the log when that macro is called:

```
***********************************************************************************
Parameter values to be used by EDWREGLIST are:
EDWREGLIST SDATEQ '2012-01-09'
EDWREGLIST SUBJECT_CODE 'ED'
EDWREGLIST DATEFIELD Start
EDWREGLIST COURSE_SECTION_TYPE   
EDWREGLIST OUT ED9920_EDW
EDWREGLIST MACRO EDWREGLIST
EDWREGLIST EDATE 09Jan2012
EDWREGLIST FOREOCE FALSE
EDWREGLIST CATALOG_NUMBER '9920'
EDWREGLIST CAREER_CODE  'UGRD' 'GRAD' 
EDWREGLIST SCHOOL_CODE
EDWREGLIST SDATE 09Jan2012
EDWREGLIST LRNR_EMPLID
EDWREGLIST EDATEQ '2012-01-09'
EDWREGLIST INST_EMPLID
***********************************************************************************
```

i'm quite certain i've poached this from somewhere else--either another blog, a training course, or someone else's code--but i don't know where. i've been using this technique for the past few years for all macros that i write that are intended for continued use.
