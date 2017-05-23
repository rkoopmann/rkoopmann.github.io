---
layout: post
title: let that be a lesson to 'ya!
author: rkoopmann
category: sas
tags:
- tip
---

when i was young and reckless, i would change variable names to something a little more succinct and personally meaningful. i mean, `email` has a better ring to it than does `person_email_address`.

<!--more-->

the problem with this is when trying to document the variables that your programs use to guestimate how changes to underlying data structures might affect your programs. you called it `email` here, `email_address` there, and `EmailAddress` elsewhere, none of which map to the original name without human intervention.

when you're working with dozens of databases, each with dozens of tables and hundreds of variables (i'm talking nearly 2,500 variables at the end of the day), such on-the-fly renaming recklessness will end up biting you.

just my $0.02.