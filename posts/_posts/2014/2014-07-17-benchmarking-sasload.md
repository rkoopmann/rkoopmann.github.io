---
layout: post
title: Benchmarking the sasload Statement
category: sas
tags:
- benchmark
- sas
---

in the middle of re-writing some macro code where different datasets were being accessed a number of times, i came across the `sasload` statement being called for each datasets. something like this:

```text
sasfile sashelp.stocks open;
	%macro1();
	%macro2();
	%macro3();
sasfile sashelp.stocks close;

sasfile sashelp.class open;
	%macro1();
	%macro4();
sasfile sashelp.class close;
```

<!--more-->

i'd always assumed that the `sasfile` would speed up subsequent dataset access time, but never really checked.

so i'm fixing that now.

first, a couple novel macros that i'm using for this benchmark.

```text
%macro grabTime(stop);
	%global teststart;
	proc sql;
	select distinct
	%if "&stop" eq "" %then
		datetime() format=20.6
		into :testStart
	;
	%else
		datetime() - &teststart format=20.6
	;
	from sashelp.class;
	quit;
%mend;

%macro summarize(dataset,class,variable,suffix);
proc summary data=&dataset nway;
	class &class;
	var &variable;
	output out=Test&suffix mean=;
run;
%mend;

%macro levels(dataset,variable,suffix);
proc freq levels data=&dataset;
	table &variable;
run;
%mend;
```

**baseline**

run two macros in sequence 500 times.

```text
%macro baseline;
%grabtime();

%do i = 1 %to 500;
	%summarize(sashelp.stocks,stock,open,&i);
	%levels(sashelp.stocks,stock,&i);
%end;

%grabtime(stop);
%mend;
%baseline;
```


**`sasfile` outside loop**

run two macros in sequence 500 times but load the dataset at the start and end.

```text
%macro outside;
%grabtime();

sasfile sashelp.stocks open;
%do i = 1 %to 500;
	%summarize(sashelp.stocks,stock,open,&i);
	%levels(sashelp.stocks,stock,&i);
%end;
sasfile sashelp.stocks close;

%grabtime(stop);
%mend;
%outside;
```


**`sasfile` inside loop**

run two macros in sequence 500 times but load the dataset each iteration.

```text
%macro inside;
%grabtime();

%do i = 1 %to 500;
	sasfile sashelp.stocks open;
	%summarize(sashelp.stocks,stock,open,&i);
	%levels(sashelp.stocks,stock,&i);
	sasfile sashelp.stocks close;
%end;

%grabtime(stop);
%mend;
%inside;
```

turns out, in this benchmark, *not* using `sasfile` is actually the best option.

- baseline: 12.964 seconds.
- `sasfile` outside loop: 13.432 seconds (+3.61%).
- `sasfile` inside loop: 14.166 seconds (+9.27%).

