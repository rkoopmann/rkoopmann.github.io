---
layout: post
title: the positive side of keeping all your eggs in one basket
category: sas
tags:
- sas
- tip
---

in any work environment with multiple SAS users, the are likely common data sources used by all or most users. how do you go about deciding *where* to define the connections to these common data sources?

<!--more-->

here's the most common options for placing libname definitions:

1. within each script,
2. within a script for a specific project/data source,
3. within each user's autoexec file, or
4. within a common autoexec file.

if integrated security is available, *or* if **all** users can be identified with `&SYSUSERID` and share the **same** password, *or* if **all** users share the same credentials, you'd prefer option 4. lower numbered options have the issue of keeping definitions to the same data source across multiple locations. (i'd argue that options 3 & 4 are the only reasonable options.)

changes to data source connections further complicates things, but the impact can be enormous if options 1 or 2 was used. you'll put your work on hold while you scour old code making modifications to the numerous libname definitions; i'll make a handful of changes in 2 files and get actual work done.
