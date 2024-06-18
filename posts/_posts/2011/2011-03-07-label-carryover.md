---
layout: post
title: Label Carryover
category: sas
tags:
- sas
- tip
---

a little demo on label carryover.

<!--more-->

```sas
data a;
	a=1;
	b=2;
	label a='from dataset a';
run;

data b;
	a=3;
	b=4;
	label b='from dataset b';
run;

data c;
	set a b;
run;

proc contents data=c varnum; run;
/*********************************************************************************\
			   Variables in Creation Order

#    Variable    Type    Len    Format    Label

1    a           Num       8    4.        from dataset a
2    b           Num       8    4.        from dataset b
\*********************************************************************************/;

data d;
	a=5;
	b=6;
	label a='from dataset d'
		b='from dataset d';
	set c;
run;

proc contents data=d varnum; run;

/*********************************************************************************\
			   Variables in Creation Order

#    Variable    Type    Len    Format    Label

1    a           Num       8    4.        from dataset d
2    b           Num       8    4.        from dataset d
\*********************************************************************************/;
```
