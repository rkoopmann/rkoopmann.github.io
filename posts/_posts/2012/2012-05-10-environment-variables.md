---
layout: post
title: windows environment variables
category: sas
tags:
- windows
summary: a mental not for how to fetch windows environment variables in sas.
---

essentially,

    filename oscmd pipe 'set';
    data os_env;
        infile oscmd dlm='=';
        input env_var :$32. value :$1000.;
    run;

