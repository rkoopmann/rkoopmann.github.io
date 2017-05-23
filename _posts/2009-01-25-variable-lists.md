---
layout: post
title: sas variable lists
category: sas
tags:
- tip
---

last week, there was [a blog post](http://jaredprins.squarespace.com/blog/2009/1/23/sas-and-character-variable-lists.html) regarding the use of variable lists on variables with character suffixes (e.g., `TestA--TestG`). i added my clarifications via [a comment](http://jaredprins.squarespace.com/blog/2009/1/23/sas-and-character-variable-lists.html#comments), but thought some examples would be more useful. let’s fire up sas (9.1.3) and get going.

<!--more-->

here’s our test dataset; notice the variables are not defined in order of their suffixes (`nn1` is defined first, later `nn3` gets defined, and still later `nn2` is defined; same goes for the other variables).

    data test;  
      nn1=1; *numeric variable, numeric suffix;  
      nca=1; *numeric variable, character suffix;  
      cn1='a'; *character variable, numeric suffix;  
      cca='a'; *character variable, character suffix;  

      nn3=3;  
      ncc=3;  
      cn3='c';  
      ccc='c';  

      nn2=2;  
      ncb=2;  
      cn2='b';  
      ccb='b';  
      format n: 3. c:$3.;  
    run;

looking at the output from proc contents, we can confirm the ordering of the variables.

          Variables in Creation Order  
    
     #    Variable    Type    Len    Format 
    
     1    nn1         Num       8    3.  
     2    nca         Num       8    3.  
     3    cn1         Char      1    $3.  
     4    cca         Char      1    $3.  
     5    nn3         Num       8    3.  
     6    ncc         Num       8    3.  
     7    cn3         Char      1    $3.  
     8    ccc         Char      1    $3.  
     9    nn2         Num       8    3.  
    10    ncb         Num       8    3.  
    11    cn2         Char      1    $3.  
    12    ccb         Char      1    $3.

let’s look at accessing **numeric variables with numeric suffixes** first with a numbered range list, then with a name range list. (these are terms straight from [sas help](http://support.sas.com/onlinedoc/913/getDoc/en/lrcon.hlp/a000695105.htm), in my original comment i called them _variable lists_ and _variable ranges_, respectively).

    numbered range list: nn1-nn3  
    nn1    nn2    nn3  
      1      2      3  

    name range list: nn1--nn3  
    nn1    nca    cn1    cca    nn3  
      1      1    a      a        3

note the numbered range list returns the variables in sequential order of the suffix while the named range list returns the variables in the order they appear in the dataset.

next, let’s look at character variables with numeric suffixes.

    numbered range list: cn1-cn3  
    cn1    cn2    cn3  
    a      b      c  

    named range list: cn1--cn3  
    cn1    cca    nn3    ncc    cn3  
    a      a        3      3    c

same idea as before.

now, let's take a look at **numeric variables with character suffixes**. it's worth noting that **numbered range lists _do not work_ unless the suffix is _numeric_**. sas will throw an error into the log indicating this.

    named range list: nca--ncc  
    nca    cn1    cca    nn3    ncc  
      1    a      a        3      3
      
maybe numbered range lists will work on **character variables with character suffixes**?

    named range list: cca--ccc  
    cca    nn3    ncc    cn3    ccc  
    a        3      3    c      c

same story--numbered range lists only work on variables with numeric suffixes.

a **name prefix** list provides us with results that are likely closer what was desired.

    name prefix list: nn:  
    nn1    nn3    nn2  
      1      3      2  

    name prefix list: nc:  
    nca    ncc    ncb  
      1      3      2  

    name prefix list: cn:  
    cn1    cn3    cn2  
    a      c      b  

    name prefix list: cc:  
    cca    ccc    ccb  
    a      c      b

name prefix lists respect creation order. also, if i had a variable named `nnn` or `nn815`, those would be included for the name prefix range `nn:`.