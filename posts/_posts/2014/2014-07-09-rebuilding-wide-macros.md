---
layout: post
title: rebuilding wide macros
author: rkoopmann
category: sas
tags:
- sas
- sas macro
---

Recently I needed to pull the values of potentially long macro variables (more than 200 characters) from the dictionary tables (`sashelp.vmacro` in this case). I couldn't simply use the actual macro variable because the main program was dataset-driven. The bottom line was that I needed a dataset containing the macro values in a single variable with one observation per macro variable.

<!--more-->

For example,

```text
data _null_;
	format long_macro $512.;
	long_macro=repeat('0123456789ABCDEF', 31);
	call symput('LONG_MACRO', long_macro);
run;

proc print data=sashelp.vmacro noobs;
    where scope eq 'GLOBAL'
    	and name eq 'LONG_MACRO';
    format value $25.;
    var offset value;
run;

/* output
offset    value

    0     0123456789ABCDEF012345678
  200     89ABCDEF0123456789ABCDEF0
  400     0123456789ABCDEF012345678
*/
```

My initial approach was to simply go over the dictionary table and retain/append a new variable but neither `cat` nor `||` worked quite right. The issue is that spaces are important in my case, so the `cats` function was a no-go[^The macro values could contain spaces and if those spaces happened to land on the 200-character increments, then two words would get smashed together.].

I *could* have used a `substr` function on the left of the equal like this:

```text
data _null_;
	set sashelp.vmacro;
	where scope eq 'GLOBAL'
		and name eq 'LONG_MACRO';
	format fullvalue $512.;
	retain fullvalue;
	start = (_n_-1) * 200 + 1;
	substr(fullvalue, start, 200) = value;
	length=length(fullvalue);
	put _n_ @5 start @10 length fullvalue $25.;
run;

/* output
1   1    200 0123456789ABCDEF012345678
2   201  400 0123456789ABCDEF012345678
3   401  500 0123456789ABCDEF012345678
*/
```

Which is simple enough when you need to get to exactly one macro variable, but with more than one, you'd need to sort the data and use `first.` variables to set up and increment a counter variable as opposed to simply using `_n_`.

Then I figured I'd try to simply transpose the dictionary table and then `cat` the different columns. This worked.

```text
***	get the macro snippets sorted right.;
proc sort data=sashelp.vmacro out=macros;
	by scope name offset;
run;

***	transpose by scope and name on offset.;
proc transpose data=macros
		out=macros prefix=offset_;
	by scope name;
	id offset;
	var value;
run;

***	reassemble macros to original (wider) values.;
data macros(rename=value2=value);
	format scope name $32. value2 $32000.;
    set macros;
	value2 = cat(of offset_:);
	drop value offset_: _name_ _label_;
run;
```

Now I have access to the full macro variable values from a dataset for any proc I need.
