---
layout: post
title: PROC PWDECODE
category: sas
tags:
- hack
- sas
---

just read a posting about how to [encode sas passwords](http://sas-bi.blogspot.com/2008/12/example-to-encode-sas-passwords.html). i've been using encoded passwords for a few years because the prevent casual snoopers from getting access to credentials they shouldn't have. encoded passwords do not, however, prevent decoding. you know, in case you forget your password. normally, if you want to access the resource outside of sas, an encoded password is useless.

<!--more-->

as of v 9.1.3 sp4, sas encodes passwords using base 64. here are two ways i decode encoded passwords: [base 64 decoder from opinionatedgeek](http://www.opinionatedgeek.com/dotnet/tools/Base64Decode/Default.aspx), and [pspad](http://www.pspad.com/en/download.php) (Edit > Special conversion > Base64 -> ANSI). with either of these methods, you'll want to leave off the `{sas001}` and decode only `bXluM3dwd2Q0dQ==` to get `myn3wpwd4u`.
