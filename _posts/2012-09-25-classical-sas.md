---
layout: post
title: classical sas
category: sas
tags:
- music
summary: his fifth.
link: http://pramod-r.blogspot.com/2011/03/using-sas-as-my-/blogmakeshift-alarm-using.html
---

Seeing [Pramod R's post](http://pramod-r.blogspot.com/2011/03/using-sas-as-my-makeshift-alarm-using.html) reminded me of something I pulled off a number of years ago after seeing [this SAS-L post](http://www.rhinocerus.net/forum/soft-sys-sas/520907-re-ot-chance-make-sas-l-history-did-you-know.html).

I implemented a sas program which played the first few bars of Bethoveen's Fifth Symphony.

<!--more-->

That alone was neat and all, but I felt the *real* joy was `%include`ing it in the site autoexec file. Simply adding it to execute every time a client started SAS would have been an overkill, so instead, I had the tune play only on Monday mornings and only if the client started up SAS *before* 9 AM.

    if weekday("&SYSDATE9"d) = 2 and "&SYSTIME"t < '09:00't;

After a few months, i'd forgotten about adding the Fifth to the autoexec until my manager asked that I look at a co-worker's installation. Apparently, the co-worker was at her wit's end with an elusive sas 'trouble'. In corporate world running PCs, the kneejerk reaction is 'virus?' and, with that, the IT department was called up a number of times.

After laughing for a few minutes, I quickly commented out the include statement, but kept the code.