---
layout: post
title: what's the point of this?
author: rkoopmann
category: sas
tags:
- array
- do loop
- rant
summary: 
updated: true
---

i'm working on some survey data containing a few select all that apply-type items. in the data set, they have the same number of variables, but they aren't dummy variables as i expected. for some reason that escapes me, they "pushed" all the selected response options to the left.

<!--more-->

That is, if there were 4 response options and i picked the first and third option, i'd see the first variable has a value of 1, the second variable has a value of 3, and the remaining two variables are missing. that is, rather than `1, 0, 1, 0`, they have `1, 3, ., .`.

what is the point of this? why not have corresponding dummy variables? it's not like they are stored in rank order, otherwise i'd expect to see response options in mixed order. for example, `3, 2, 4, .`, but this is never the case. the first is always the minimum and the last is always the maximum. `2, 3, 4, .`. no rank information is collected or saved. now, i'm working on an elegant fix to this wtf. do-loops and arrays are definitely involved in the solution, but so far, i can't seem to get it working properly.

UPDATE and it's done.

    data _null_(drop=i j _selected_);
      array q66o(4);
      input q66o1-q66o4;
      put 'OLD' @5 q66o1-q66o4;
      do i = dim(q66o) to 1 by -1;
        _selected_ = 0;
        do j = 1 to i;
          _selected_ = _selected_ + (q66o(j) = i);
        end;
        q66o(i) = _selected_;
      end;
      put 'NEW' @5 q66o1-q66o4/;
    datalines;
    1 2 3 4
    1 2 4 .
    2 4 . .
    1 . . .
    4 . . .
    . . . .
    run;

makes this

    OLD 1 2 3 4
    NEW 1 1 1 1
    
    OLD 1 2 4 .
    NEW 1 1 0 1
    
    OLD 2 4 . .
    NEW 0 1 0 1
    
    OLD 1 . . .
    NEW 1 0 0 0
    
    OLD 4 . . .
    NEW 0 0 0 1
    
    OLD . . . .
    NEW 0 0 0 0
