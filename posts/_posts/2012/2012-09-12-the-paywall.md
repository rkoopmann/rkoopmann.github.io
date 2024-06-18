---
layout: post
title: The Paywall, the Backdoor, and Twitter
subtitle: "how twitter facilitated a backdoor to Ben Brooks' paywall"
category: post
tags:
- hack
---

Personally, I like Ben Brooks' writing style--both [long form](http://brooksreview.net/)  and even though Ben is pulling the plug on his [short form](http://twitter.com/benjaminbrooks/)--and I thoroughly enjoy his [weekly conversations](http://thebbpodcast.com/) with fellow tech writer [Shawn Blanc](http://shawnblanc.net/).

<!--more-->

## The Paywall ##

Recently, Ben put up what I'll call a *porous* paywall on his site, [*The Brooks Report*](http://brooksreview.net). It's porous in the sense that members can link to new content for non-members to view directly. Non-members cannot browse the new posts until one week after they are published at which time everyone can see posts.

Some in the tech blogosphere had doubts this model would work (e.g., Marco, The Beard), but its been a few months since the change and all seems to be going well enough.

At first, I wasn't going to sign up, but the effect of seeing someone whose opinion I respect apparently reporting on last week's events this week was just enough to push me over to the members side of things. Since I like Ben's style, I signed up without much thought--That wasn't true at the time of my discovery, but it is now.<label for="mn1" class="margin-toggle sidenote-number"></label><input type="checkbox" id="mn1" class="margin-toggle"/><span class="sidenote">Let me preface this post by saying I (tend to) prefer to pay for an app or service that I use and like even when the same app or service is offered at no charge (simplenote, instapaper, flickr) or when free alternative apps or services are available (twitter &lt; app.net, delicious &lt; pinboard.in).</span>

Fellow followers of the twitter and app.net accounts for *The Brooks Review* may notice that the links are all under the domain `http://tbr.mx` which uses the URL-shortener bitly behind the scenes.

## The Backdoor.rss ##

Recently, I needed to shorten a GitHub project URL so I jumped over to my bitly account. That was when I noticed that bitly shows URLs that others in your [bit.ly network](https://bitly.com/a/network) have recently created.

Wait. A bit.ly network? Makes sense, I guess. Everyone is going social, so why not socialize (not *that* socialize) a URL tracking site, right?

Back to the point, in my bit.ly network is one [thebr](http://bitly.com/u/thebr) account held by Ben Brooks that tweets out a link whenever a new post hits his website. And as I found out, converting a bit.ly user page into an RSS feed is as simple as appending `.rss` to the end of the URL.

Once we have an RSS feed, two big holes in Ben's porous paywall open up:

- anyone can easily add the feed to their favorite RSS reader
- anyone can use ifttt to do god-knows-what with it

So I created two ifttt recipes: one that appends to a Dropbox file and another that downloads the RSS item to HTML. Both are functional, but are limited by the bit.ly redirect.

```
Little Things: Photo Printing — The Brooks Review

http://tbr.mx/ORBtVW

thebr shortened a link to this page on bitly: <a href='http://tbr.mx/ORBtVW'>http://tbr.mx/ORBtVW</a>
Source: http://brooksreview.net/2012/09/lt-photo-printing/
See who else is talking about this page <a href='http://tbr.mx/ORBtVW+'>http://tbr.mx/ORBtVW+</a>

via Recent Bookmarks from thebr on bitly http://bitly.com/u/thebr.rss

September 04, 2012 at 11:30PM

- - - - -

Quote of the Day: Dave Pell — The Brooks Review

http://tbr.mx/NM9b4z

thebr shortened a link to this page on bitly: <a href='http://tbr.mx/NM9b4z'>http://tbr.mx/NM9b4z</a>
Source: http://t.co/WxPbCT3V
See who else is talking about this page <a href='http://tbr.mx/NM9b4z+'>http://tbr.mx/NM9b4z+</a>

via Recent Bookmarks from thebr on bitly http://bitly.com/u/thebr.rss

September 05, 2012 at 08:39AM

- - - - -
```

## Twitter ##

This is all possible because of twitter and bitly's defaulting accounts (and thus their new links) to be public.

At some point in the past, I had connected my bitly account with my twitter account; Ben Brooks did the same with his accounts. Because I follow Ben Brooks' twitter accounts on twitter, bit.ly shows me all the recent links he makes. bitly explains the network like this:

> Know all those friends of yours on Facebook and the folks you follow on Twitter? Well, if they use bitly, whenever they save a public bitmark, it shows up here!

I've since changed my bitly account to be private. It's [super easy](http://bitly.com/a/settings/saving), but should be private by default.

## The Fallout ##

Last week, I let Ben know about this hole and he made the appropriate changes to the bitly account which makes newly-created shortened URLs private and disables the +`.rss` trick.
