---
layout: post
title: Calculating Average Time (Duration)
category: sas
tags:
- datetime values
- sas
---

**this is summarizes [my response](http://support.sas.com/forums/message.jspa?messageID=23047#23047) to [a thread](http://support.sas.com/forums/thread.jspa?threadID=6386) on the [SAS Discussion Forums](http://support.sas.com/forums/index.jspa).**

<!--more-->

in the [original post](http://support.sas.com/forums/message.jspa?messageID=22993#22993), the poster wanted “…to calculate the length of time (mean, median, and mode) between when a record was created ("date reported" in my database) and when that same record was returned ("date closed" in my database).”

in a [follow-up post](http://support.sas.com/forums/message.jspa?messageID=23001#23001), the original poster used an analogy of watching a particular TV channel. that is, “…when a person turned on the channel and when they turned off the channel.”

so i set up some fake data to work the problem out.

    data EventData;
        format EventID 8. EventOpenDT EventCloseDT datetime.;
        do EventID=1 to 1000;
            EventOpenDT =dhms('01jul2009'd, 0, 0, floor(ranuni(123)*24*60*60));
            EventCloseDT=dhms('02jul2009'd, 0, 0, floor(ranuni(456)*24*60*60));
            output;
        end;
    run;

the discussion then turned to [SUMMARY/MEANS procs](http://support.sas.com/forums/message.jspa?messageID=23004#23004) and [exactly how date, time, and datetime values are derived in SAS](http://support.sas.com/forums/message.jspa?messageID=23006#23006). at the risk of stating the obvious, i think the other posters missed the main issue the original poster had: trying to calculate the average difference between two datetimes vs. calculating the diference between the average of two datetimes. the duration needs to be calculated for each record in the raw data before summarizing. [one poster implied this](http://support.sas.com/forums/message.jspa?messageID=23012#23012), but never explicitly stated it.

step 1: calculate duration for raw data

    data EventData;
        set EventData;
        EventDuration=intck('dthour', EventOpenDT, EventCloseDT);
    run;

step 2: summarize duration

    proc univariate data=eventdata noprint;
        var eventduration;
        output out=EventSummary n=N mode=Mode mean=Mean median=Median;
    run;

    proc print noobs;
    run;

results

    N      Mean     Median    Mode
    1000    23.945      24       25
