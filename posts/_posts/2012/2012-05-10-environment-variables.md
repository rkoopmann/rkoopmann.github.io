---
layout: post
title: Windows Environment Variables
category: sas
tags:
- windows
- sas
summary: a mental note for how to fetch windows environment variables in sas.
---

essentially,

    filename oscmd pipe 'set';
    data os_env;
        infile oscmd dlm='=';
        input env_var :$32. value :$1000.;
    run;

