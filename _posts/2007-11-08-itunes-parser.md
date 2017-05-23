---
layout: post
title: itunes xml parser
author: rkoopmann
category: sas
tags:
- xml
summary: wherein i coerce sas into consuming the iTunes library xml file.
---

today, i published [`itunes.sas`][1], an itunes xml library parser and [`itunes_analyzer.sas`][2] to the [quatch project][3].

<!--more-->

the `iTunes Music Library.xml` is a very odd beast. rather than storing song information like this: `Song Title` apple chose to do it the more painful way: `TitleSong Title`

my motivation for writing this was pretty simple: to figure out which albums have on my ipod that i don't listen to often enough to justify the hdd space they occupy. once identified, i can simply uncheck them and sync up. i can tell you right now, i don't think queensryche's _empire_ is going to make the cut…

[1]: https://github.com/rkoopmann/sas-quatch/blob/master/google-code-files/itunes.sas
[2]: https://github.com/rkoopmann/sas-quatch/blob/master/google-code-files/itunes_analyzer.sas
[3]: https://github.com/rkoopmann/sas-quatch 