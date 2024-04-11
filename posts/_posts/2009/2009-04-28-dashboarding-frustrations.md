---
layout: post
title: frustrations with dashboarding in sas 9.1.3
category: sas
tags:
- dashboard
- sas
---

I've gone through the work of creating a dashboard using SAS/GRAPH and summary data sets. I've got my autoexec to re-build the dashboard on a daily basis, which takes roughly 5 minutes each morning. it works.

<!--more-->

but not really. the main issue is that it’s done in sas 9.1.3, so i can’t take advantage of all the enhancements that [9.2 brings to graphics](http://support.sas.com/documentation/cdl/en/whatsnew/62435/HTML/default/graphrefwhatsnew902.htm). [the most noticeable result](http://groups.google.com/group/sas_quatch/t/eddee276ae3a6a61) is in the graphics—-they are created in raster, not vector formats. so getting the sizing right was very important. secondly, i couldn’t take advantage of the new procedures (mainly [`proc gkpi`](http://support.sas.com/documentation/cdl/en/graphref/61884/HTML/default/a003163556.htm)) and the [graph template language](http://support.sas.com/documentation/cdl/en/grstatug/61950/HTML/default/titlepage.htm).

after attending [Stephen Few's visual business intelligence workshops last week](http://www.perceptualedge.com/workshops.php), i was struck with a case of dashboard envy. this got me thinking about other technologies to enhance the end-user experience.

some solutions that popped into my head: [sas bi](http://www.sas.com/technologies/bi/), [adobe flex](http://www.adobe.com/products/flex/), and [microsoft sharepoint](http://www.microsoft.com/Sharepoint/default.mspx). i thought all were worth taking a serious look at. but then it hit me. I'm pretty sure i don’t want to learn *another* programming language to get an *existing* dashboard to look proper. (if I'm going to learn a new language, it’d be python or r.) besides, I'm already using sas for the ETL, analysis, and 95% of my reporting needs.

so i don’t want to learn a new language, but i do want the dashboard to look like it was created sometime after 1980. what options are left?

[google chart api](http://code.google.com/apis/chart/)

think about it. Google chart API allows up to 250,000 calls per day. assuming 100 graphics on a dashboard that 100 people would be viewing each day, each person could open the dashboard 25 times a day. i could also create the dashboard and then save as complete webpage. and if more calls would be needed, Google seems pretty open to accommodating. but since the underlying data wouldn’t be updated more than once a day, i think I'm safe for a few years.

in terms of time to results, i think Google chart API is the most viable solution since i don’t need to learn another language, just how to make Google chart API calls.

a [brief search](http://www.google.com/search?q=google-chart-api+sas) yielded surprisingly few hits. [minequest has two (fairly dated) macros for bar charts and pie charts](http://www.minequest.com/downloads.html), but i couldn’t get the code to run. so I'm starting to develop a sas macro to generate Google chart API-friendly URL which are based on SUMMARY procedure output data sets.

if things work out as expected, I'll eventually need to incorporate [Google visualization API as well](http://code.google.com/apis/visualization).
