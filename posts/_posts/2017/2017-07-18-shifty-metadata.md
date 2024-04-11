---
layout: post
title: shifty metadata
category: sas
tags:
- Excel
- function
- sas
---

I've got a set of Excel files (.xlsx) containing weekly spend breakouts. These files are *supposed* to be formatted identically, but they're not. Across these files, a couple numeric variables are sometimes read as text. That makes stacking data impossible.

I could probably develop some overly-complicated bit of code to extract the schema from the dictionary tables and then adjust the import code on the fly. But that's work.

Here's what I did instead:

```sas
a_number=input(compress(vvalue(any_variable), ' $,'), 16.8);
```

Let's unpack that:

1. `vvalue` takes a variable (numeric or character, doesn't matter) and outputs the formatted value as character,
2. `compress` the resulting string to remove spaces, commas, and *$*s, and
3. `input` to convert character to numeric.
