---
layout: post
title: Introducing meandfreq
category: sas
tags:
- sas
- sas macro
- quatch
---

i've uploaded a fairly simple macro ([MeanFreq](/assets/sas/MeanFreq.sas)) that analyzes a variable both as an interval and nominal/ordinal. that is, it reports out the overall valid count, missing count, mean, and standard deviation as well as frequencies and percents.

the macro analyzes one variable per call and can handle one optional by-variable -- if a by-variable is specified, the macro also generates an overall record.

the to-do list for this macro includes:
- add checks for too many discrete values.
- add ability to processes multiple variables in one call.
- add ability to have multiple by-variables in one call.

while treating likert-type responses for surveys is not correct, let's face it: everyone does it and expects it. so you may as well do it and provide the correct reporting method right next to it.

for example, submitting `%MeanFreq(data=sashelp.class, by=sex, var=age, out=class);`

produces this:

    Sex     N_Valid    N_Missing        Mean      StdDev        f_11        f_12        f_13        f_14

                 19           0      13.3158      1.4927           2           5           3           4
     F            9           0      13.2222      1.3944           1           2           2           2
     M           10           0      13.4000      1.6465           1           3           1           2

    Sex        f_15        f_16        p_11        p_12        p_13        p_14        p_15        p_16

                  4           1     10.53%      26.32%      15.79%      21.05%      21.05%       5.26%
     F            2           0     11.11%      22.22%      22.22%      22.22%      22.22%       0.00%
     M            2           1     10.00%      30.00%      10.00%      20.00%      20.00%      10.00%
