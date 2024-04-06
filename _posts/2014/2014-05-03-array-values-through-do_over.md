---
layout: post
title: 'setting %array values through %do_over'
date: 2014-05-03
drafted: 2014-04-02
category: sas
tags:
- sas
- sas macro
---

I've been using Ted Clay's `%array` and `%do_over` macros lately. a lot. Everytime I think I've hit a wall with what these two macros can do, I look back at Ted's [Coders' Corner paper][tight-looping] for SUGI 31--that'd be *SGF 2006* in SAS Global Forum terms.

[tight-looping]: http://www2.sas.com/proceedings/sugi31/040-31.pdf "Tight Looping With Macro Arrays"

Recently, I was working on a macro to handle a set of an unknown number of variables. Depending on the number of variables in each set, I had to kick off another macro and, conditionally, execute some other statements.

This sounded like the perfect situation for `%array` and `%do_over`.

<!--more-->

So I checked if this works:

```
%array(seq, values=%do_over(values=1-5, phrase=V?));
%put %do_over(seq);
```

good news: it worked exactly as one would expect.

```
V1     V2     V3     V4     V5
```


this can taken a bit further by specifying the number of elements in a different array as the end point...

```
%array(abc, values=A B C);
%array(seq, values=%do_over(values=1-&ABCN, phrase=V?));
%put %do_over(seq abc, phrase=?seq is ?abc.);
```

which does this

```
V1 is A.     V2 is B.     V3 is C.
```


and even *further* by calling a macro.

```
%macro echo(x,y);
    %put &X. is &Y..;
%mend;
%do_over(seq abc, macro=echo);
```

which makes this

```
V1 is A.
V2 is B.
V3 is C.
```

retrofitting a keyword macro is simple enough.

```
%macro echoagain(x, y, z=&y);
    %put &X. is &Y. (Z=&Z.).;
%mend;
%do_over(seq abc, macro=echoagain);
```

returning these results

```
V1 is A (Z=A).
V2 is B (Z=B).
V3 is C (Z=C).
```
