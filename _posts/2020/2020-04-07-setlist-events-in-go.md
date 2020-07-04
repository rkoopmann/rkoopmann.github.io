---
layout: post
title: setlist events in go
categories: post
tags:
- golang
date: 2020-04-07 12:00:00 -0500
---

Over the past few months, I've been toying around with [go](http://golang.org). Python has never really clicked for me. And forget about r. As you might imagine, working with APIs in SAS felt like an overkill. In bash it was a little more sane, but still felt a bit off.

Rather than tackling a work project, I opted to focus on one with a lot less complexity: setlist.fm api.

The details are in the [github repo](https://github.com/rkoopmann/setlist.fm.go). Primarily, I wanted to be able to retail a full listing of events I attended even if setlist.fm goes away. Secondarily, I wanted these listings to be usable in Jekyll. Thus, under the [events](/events/) page, I'm able to calculate some high-level stats along with an [event-level list](/events/list/). I'm still responsible for keeping my copy of things up-to-date with what's on setlist.fm, but this is a much cleaner approach than the [original method](https://github.com/rkoopmann/rkoopmann.github.io/tree/master/_events) I was attempting.
