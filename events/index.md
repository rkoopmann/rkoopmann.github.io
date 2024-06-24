---
layout: default
title: events
permalink: /event/
navigation_weight: 40
category: index
---

{% assign eventList  = site.data.events.list.Event %}
{% assign artistList = site.data.events.list.Event | map: "Artist" | compact | uniq %}
{% assign venueList  = site.data.events.list.Event | map: "Venue"  | compact | uniq %}
{% assign cityList   = site.data.events.list.Event | map: "City"   | compact | uniq %}
{% assign stateList  = site.data.events.list.Event | map: "State"  | compact | uniq %}
{% assign dateList   = site.data.events.list.Event | map: "Date"   | compact | uniq | reverse_sort %}
{% assign lastShow   = site.data.events.list.Event | first %}
{% assign firstShow  = site.data.events.list.Event | last %}

<style>
div.index-item {
  text-indent: -4.6em !important;
  padding-left: 4.6em !important;
}
</style>


I enjoy a good show and have attended quite a fair number in my youth.
I've got the [tinnitus](https://en.wikipedia.org/wiki/Tinnitus#Signs_and_symptoms) to prove it.
I didn't do much in terms of keeping track of which concerts I attended and when (I used to have all the ticket stubs, but lost those), let alone who the opening acts were, but I've reconstructed everything before 2010 as best I could.
The 90's remain a bit of a blur.

## Overview

_These stats do not include upcoming, postponed, or otherwise cancelled events._

Between {{ firstShow | map: "Date" }} and {{ lastShow | map: "Date" }}, I've attended {{ eventList | size }} performances, {{ artistList | size }} artists, {{ dateList | size }} shows, {{ venueList | size }} venues, {{ cityList | size }} cities, & {{ stateList | size }} states.

Here's a timeline showing cumulative performances I've attended. The vertical lines mark festivals which are generally responsible to large bumps. Festivals are nice (depending on weather), but I've sworn off going to them after [Vans Warped Tour coincided with Ozzfest 1998](/event/1998-07-18), a wonderful show, but just too many bands across too many stages without a good schedule.

<script src="/assets/d3.v7.min.js"></script>
<div id="chart"></div>
<script src="/assets/cumulative-events.js"></script>

<p>Some of the artists are repeats: {% assign topArtists = site.data.events.list-artists | where_exp: "e", "e.events.size >= 2" %}
{%- for e in topArtists -%}
<em><a href="/event/artist/{{ e.artist | slugify }}">{{ e.artist }}</a></em> ({{ e.events.size }}×){% unless forloop.last %}, {% endunless %}
{%- endfor -%}
</p>

<p>Most of the venues are repeats: {% assign topVenues = site.data.events.list-venues | where_exp: "e", "e.show.size >= 2" %}
{%- for e in topVenues -%}
<em><a href="/event/venue/{{ e.venue | slugify }}">{{ e.venue }}</a></em> ({{ e.show.size }}×){% unless forloop.last %}, {% endunless %}
{%- endfor -%}
</p>


## Complete Listing

Here's the complete listing of events which I had tickets to attend; Despite my original ticket purchase, I did not attend those formatted as <s>strikethrough</s> for some reason; typically cancelled or postponed events or the artist I was most interested in seeing backed out (I'm looking at you, [Beck](/event/2022-11-13/)).

{% assign items_by_year = site.data.event-shows | group_by_exp: "x", "x.date | date:'%Y'" | reverse %}

{% for year in items_by_year %}
<tt><strong>{{ year.name }}</strong></tt>
  {% assign dates = year.items | reverse %}
  {% for item in dates %}
  {% assign eventDate = item.date | date: "%Y-%m-%d" %}
  {% assign eventArtists = site.data.events.list.Event | where_exp: "e", "e.Date == eventDate" | natural_sort: "Artist" %}
  {% assign eventArtistCount = eventArtists | size %}
  <div class="index-item"><span class="post-meta"><tt><a class="post-link" href="/event/{{ item.date | date: "%Y-%m-%d" }}">{{ item.date | date: "%b %d" }}</a></tt></span> &mdash; {% if eventArtistCount == 0 %}<s>{% endif %}<em>{{ item.show | escape }}</em>{% if eventArtistCount == 0 %}</s>{% endif %}{% if eventArtistCount > 0 %} &mdash; Lineup: {% for a in eventArtists %}{% if eventArtistCount > 1 and forloop.last %}& {% endif %}{{ a.Artist }}{% unless forloop.last %}, {% endunless %}{% endfor %}{% endif %}</div>
  {% endfor %}
{% endfor %}

_The underlying data is sourced from [my setlist page](https://www.setlist.fm/concerts/rkoopmann) and gathered through [setlist.fm.go](/post/2020-04-07/).
At times, this page may lag behind, but I try to keep it up to date.
For reasons and things, [I create an ICS file of these events](/assets/refresh-events-ics.sh).
If you're weird, you can [grab a copy](/assets/events.ics)?_
