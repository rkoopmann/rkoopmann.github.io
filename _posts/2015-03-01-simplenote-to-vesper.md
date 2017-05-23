---
layout: post
title: Simplenote to Vesper
categories: ios
tags:
- app
link: http://stackoverflow.com/a/14416896/142229
date: 2015-03-01 20:00:00 -0500
---

It started with [a tweet from @benjaminbrooks][ben]:

<blockquote class="twitter-tweet" lang="en"><p>Has anyone written a tool to move your data somehow from Simplenote to Vesper, asking for me. I mean a friend, like someone else.</p>&mdash; Ben Brooks (@BenjaminBrooks) <a href="https://twitter.com/BenjaminBrooks/status/571438237710811136">February 27, 2015</a></blockquote> <script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

[ben]: https://twitter.com/BenjaminBrooks/status/571438237710811136

When Vesper first hit iOS last year, I had the same question. I wanted to give Vespre a fair chance, but without being able to import from my existing note-taking app (Simplenote), Vesper had an uphill battle. (Same goes for Drafts).

<!--more-->

On OS X, Simplenote prefers to store notes in a [SQLite][sqlite] database, so I figured Simplenote for iOS would do the same. I figured Vesper would be doing likewise. A quick check with iExplorer confirmed this.

I exported a copy of both databases and quickly created some basic SQL queries to get notes, unique tags, and note-tag combination data in reasonable format for exporting from Simplenote database and importing into Vesper database. (At this point, I force-quit Vesper on iOS.)

[sqlite]: http://www.sqlite.org


<script src="https://gist.github.com/rkoopmann/cbffa5780bfe0c9f45a0.js"></script>

Creating these queries was quick work in SQLPro for SQLite. To actually transfer the content to the Vesper database, I simply exported the resulting tables from the Simplenote database as JSON files and then imported them in the Vesper database in this order:

1. Notes
1. Tags
1. Note-Tag relations


Once that's done, copy the modified Vesper database back to the Vesper Documents directory in iExplorer (it should ask about overwriting the existing file), say yes, wait a few seconds for iExplorer to complete the sync, fire up Vesper (you already force-quit it above, right?) and look at all the Simplenote data. They should all be properly tagged and the dates intact. I think.

If only there were a Vesper for OS X available, this would possibly have been easier?

Let's see how well Vesper sticks for me now that everything is in it.

**Apps Used:**

* [Vesper][0] (iOS) $8.
* [Simplenote][1] (iOS) $0. _Notational Velocity or nvALT on OS X would probably also have the information needed, but you'd need to wrangle that data yourself._
* iExplorer (OS X). _For pulling and pushing data to your iOS device. I used version 2.2.1.6. [v. 3.6.6.0][2] might work?_
* [SQLPro for SQLite Pro][3] (OS X). At one point, this was $2; it's now $20. _If you're cozy with tromping around the terminal with SQLite, you don't really need an SQLite app. I'm cozy enough, but still prefer to use the app._

**Fair Warning**: You should never, _ever_ run code you don't understand. Backup your data. This works for me, but my Simplenote notes are fairly...simple. your results may differ. if this breaks anything, it's probably operator error. please email marco.


[0]: https://itunes.apple.com/us/app/vesper/id655895325?mt=8&at=10l4LH
[1]: https://itunes.apple.com/us/app/simplenote/id289429962?mt=8&at=10l4LH
[2]: http://www.macroplant.com/iexplorer/
[3]: https://itunes.apple.com/us/app/sqlpro-for-sqlite-sql-database/id586001240?mt=12&at=10l4LH