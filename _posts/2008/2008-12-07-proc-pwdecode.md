---
layout: post
title: PROC PWDECODE
category: sas
tags:
- sas
- hack
---

just read a posting about how to [encode sas passwords][1]. i've been using encoded passwords for a few years because the prevent casual snoopers from getting access to credentials they shouldn't have. encoded passwords do not, however, prevent decoding. you know, in case you forget your password. normally, if you want to access the resource outside of sas, an encoded password is useless.

<!--more-->

as of v 9.1.3 sp4, sas encodes passwords using base 64. here are two ways i decode encoded passwords: [base 64 decoder from opinionatedgeek][2], and [pspad][3] (Edit > Special conversion > Base64 -> ANSI). with either of these methods, you'll want to leave off the `{sas001}` and decode only `bXluM3dwd2Q0dQ==` to get `myn3wpwd4u`.

[1]: http://sas-bi.blogspot.com/2008/12/example-to-encode-sas-passwords.html
[2]: http://www.opinionatedgeek.com/dotnet/tools/Base64Decode/Default.aspx
[3]: http://www.pspad.com/en/download.php
