---
layout: post
title: Pacific Northwest SAS Users Group 2007
category: sas
tags:
- conference
- sas
- sas macro
---

My submission was accepted for presentation at the [2007 conference][pnwsug2007] of Pacific Northwest SAS Users Group in Seattle, WA. This was "Part I" of this paper; Part II was presented at [SAS Global Forum 2008](../sas-global-forum-2008/).

[Here's a local copy of the paper][local].

Here's the abstract:

> Recently, I was tasked with developing a SAS program to phase out tedious, error-prone process of transcribing a few key numbers from hundreds of item summary tables to a dozen one-page summary tables. To reduce end-user confusion, the revised reports needed to resemble the current layout and format as much as possible. Since the key statistics change across subgroups and span several item summary tables, a single tabulate or report procedure wouldn’t be sufficient. It appeared that traditional ODS reporting was out.
>
> Other reporting methods were explored, specifically `DATA _NULL_` reporting which allows the dynamic use of variables—via macro variables—and provides the layout control that would be needed. Due to the monospace appearance of these reports, however, `DATA _NULL_` reporting seemed to be out as well.
>
> Fortunately, ODS DATA Step Object’s ability to blend the layout control of `DATA _NULL_` reporting with the formatting control of traditional ODS would help save the day. with ODS DATA Step Object, SAS programmers can turn raw data into production quality reports ready for distribution. The ODS DATA Step Object is a powerful Base SAS feature that is available (in preproduction) as of version 9.1.3 and is able to generate production quality PDF reports directly since it provides SAS programmers simultaneous control over report layout and formatting.
>
> This is the first in a series of papers that will document the evolution from a reporting process that is currently only 10% SAS to one that approaches 100% SAS.
>
> The code discussed in this paper was developed with SAS 9.1.3-SP4 running under Windows XP Professional-SP2. The code was developed specifically for the PDF destination, you may experience some nuances when applying these techniques to other destinations.

I remember going into a bar next to the hotel and ordering a pint Russian Imperial Stout.
Somehow I managed to choke down about half an inch of it.
I was not prepared for that.

[pnwsug2007]: https://www.lexjansen.com/pnwsug/2007/ "Pacific Northwest SAS Users Group 2007 proceedings"
[paper]: https://www.lexjansen.com/pnwsug/2007/Richard%20Koopmann%20-%20Experimenting%20with%20the%20ODS%20DATA%20Step%20Object.pdf "Experimenting with the ODS DATA Step Object (Part I)"
[local]: /assets/pdf/2007-ods-dso-1.pdf
