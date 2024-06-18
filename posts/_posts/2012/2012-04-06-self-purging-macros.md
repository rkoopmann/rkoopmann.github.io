---
layout: post
title: Self-Purging Macros?
category: sas
tags:
- sas
- sas macro
---

unfortunately, this doesn't work:

```
%macro test;
proc catalog cat=work.sasmacr;
    delete test.macro;
run;
quit;
%mend;
%test;
```

the log

```
ERROR: Entry lock is not available for TEST.MACRO in catalog WORK.SASMACR, lock held by DMS Process.
```

nuts.
