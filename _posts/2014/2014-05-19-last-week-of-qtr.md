---
layout: post
title: last week of quarter
author: rkoopmann
category: sas
tags:
- sas
- date values
date: 2014-05-19
drafted: 2014-05-03
---

A coworker recently asked me how I would identify the last week of a quarter when the date variable is formatted as `week.2`.

Here's what I came up with.

<!--more-->

```r
data _null_;
    do i = 0 to 250;
        X_DT=intnx('week.2','01jan2010'd, i);
        last_week_of_quarter = (qtr(X_DT) ne qtr(intnx('week.2', x_dt, 1)));
    end;
run;
```

Which flagged the following dates as beginning in the last week of the quarter:

- Monday, December 28, 2009
- Monday, March 29, 2010
- Monday, June 28, 2010
- Monday, September 27, 2010
- Monday, December 27, 2010
- Monday, March 28, 2011
- Monday, June 27, 2011
- Monday, September 26, 2011
- Monday, December 26, 2011
- Monday, March 26, 2012
- Monday, June 25, 2012
- Monday, September 24, 2012
- Monday, December 31, 2012
- Monday, March 25, 2013
- Monday, June 24, 2013
- Monday, September 30, 2013
- Monday, December 30, 2013
- Monday, March 31, 2014
- Monday, June 30, 2014
- Monday, September 29, 2014

That looked good to me. All the flagged weeks we indeed at the end of the quarter.

Then the additional requirement that the X_DT values are set to the *end* of the week (Sunday), rather than the beginning (Monday). That throws a wench in things.

My initial thought was to simple add the `'e'` argument to the initial `intnx` function. But that didn't work.

- Sunday, September 30, 2012
- Sunday, March 31, 2013
- Sunday, June 30, 2013

These dates are weeks that end on the last day of the quarter. That's not quite what he was after.

Adding the `'e'` argument to the second `intnx` function as well seemed to fix things:

- Sunday, March 28, 2010
- Sunday, June 27, 2010
- Sunday, September 26, 2010
- Sunday, December 26, 2010
- Sunday, March 27, 2011
- Sunday, June 26, 2011
- Sunday, September 25, 2011
- Sunday, December 25, 2011
- Sunday, March 25, 2012
- Sunday, June 24, 2012
- Sunday, September 30, 2012
- Sunday, December 30, 2012
- Sunday, March 31, 2013
- Sunday, June 30, 2013
- Sunday, September 29, 2013
- Sunday, December 29, 2013
- Sunday, March 30, 2014
- Sunday, June 29, 2014
- Sunday, September 28, 2014

Which is the list of the last week that ends within a given quarter.
