---
layout: post
title: Vending Machine Math
category: sas
tags:
- array
- sas
---

Last week, Andy from [NOTE:](http://www.notecolon.info) introduced me to [code katas](http://www.notecolon.info/2012/01/code-katas.html). Then he posted his first one: vending machine math.

<!--more-->

> Imagine you have to write some code for a vending machine. You are given a) the price of the product to be vended, and b) the amount of money tendered by the customer. Your task is to deduce what change to offer, i.e. how many of each type of coin. Optimise your result by minimising the number of coins given in change. Assume your vending machine has unlimited stocks of the following denomination: 1p, 2p, 5p, 10p, 20p, 50p, £1, £2.

here's my solution

```
data _null_;
    array coin(8);
    array value(8) _temporary_ (1,2,5,10,20,50,100,200);

    call missing (of coin: coincount total);

    input tendered price;
    owed = tendered - price;

    put 'Price:'  @12 price
    / 'Tendered:' @12 tendered
    / 'Change due:';

    do i = dim(coin) to 1 by -1 until (owed=0);
        do until (owed < value[i]);
            if owed >= value[i] then do;
                coin[i]+1;
                owed=owed-value[i];
            end;
        end;
    end;

    do i = dim(coin) to 1 by -1;
    coin[i] = max(0,coin[i]);
    coincount + coin[i];
    subtotal = value[i] * coin[i];
    total + subtotal;
    put @6 value[i] 3.-r @10 'x' @12 coin[i] @14 '=' @16 subtotal 3.-r;
    end;

    put @11 '--- -----'
    / @10 coincount 3.-r @14 total 5.-r
    ///;

datalines;
100 70
80 63
200 45
200 11
run;
```
log, using UK coinage

    Price:     70
    Tendered:  100
    Change due:
         200 x 0 =   0
         100 x 0 =   0
          50 x 0 =   0
          20 x 1 =  20
          10 x 1 =  10
           5 x 0 =   0
           2 x 0 =   0
           1 x 0 =   0
              --- -----
               2    30

    Price:     63
    Tendered:  80
    Change due:
         200 x 0 =   0
         100 x 0 =   0
          50 x 0 =   0
          20 x 0 =   0
          10 x 1 =  10
           5 x 1 =   5
           2 x 1 =   2
           1 x 0 =   0
              --- -----
               3    17

    Price:     45
    Tendered:  200
    Change due:
         200 x 0 =   0
         100 x 1 = 100
          50 x 1 =  50
          20 x 0 =   0
          10 x 0 =   0
           5 x 1 =   5
           2 x 0 =   0
           1 x 0 =   0
              --- -----
               3   155

    Price:     11
    Tendered:  200
    Change due:
         200 x 0 =   0
         100 x 1 = 100
          50 x 1 =  50
          20 x 1 =  20
          10 x 1 =  10
           5 x 1 =   5
           2 x 2 =   4
           1 x 0 =   0
              --- -----
               7   189

it's pretty simple to change to US coinage by changing the following statements (i know there are 50 cent pieces, but i've never seen a vending machine use them):

    array coin(5);
    array value(5) _temporary_ (1,5,10,25,100);

partial log, using US coinage

    Price:     70
    Tendered:  100
    Change due:
         100 x 0 =   0
          25 x 1 =  25
          10 x 0 =   0
           5 x 1 =   5
           1 x 0 =   0
              --- -----
               2    30

    Price:     63
    Tendered:  80
    Change due:
         100 x 0 =   0
          25 x 0 =   0
          10 x 1 =  10
           5 x 1 =   5
           1 x 2 =   2
              --- -----
               4    17
