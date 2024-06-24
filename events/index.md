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

{% assign topArtists = site.data.events.list-artists | where_exp: "e", "e.events.size >= 2" %}
{% assign topVenues = site.data.events.list-venues | where_exp: "e", "e.show.size >= 2" %}

<style>
div.index-item {
  text-indent: -4.6em !important;
  padding-left: 4.6em !important;
}
</style>

# Events


I enjoy a good show and have attended quite a fair number in my youth.
I've got the [tinnitus](https://en.wikipedia.org/wiki/Tinnitus#Signs_and_symptoms) to prove it.
I didn't do much in terms of keeping track of which concerts I attended and when (I used to have all the ticket stubs, but lost those), let alone who the opening acts were, but I've reconstructed everything before 2010 as best I could.
The 90's remain a bit of a blur.

## Overview

_These stats do not include upcoming, postponed, or otherwise cancelled events._

Between {{ firstShow | map: "Date" }} and {{ lastShow | map: "Date" }}, I've attended {{ eventList | size }} performances, {{ artistList | size }} [artists](/event/artist/) ({{ topArtists.size }} repeats), {{ dateList | size }} [shows](/event/show/), {{ venueList | size }} [venues](/event/venue/) ({{ topVenues.size }} repeats), {{ cityList | size }} cities, & {{ stateList | size }} states.

Here's a timeline showing cumulative [performances](/event/show/) I've attended. The vertical lines mark festivals which are generally responsible to large bumps. Festivals are nice (depending on weather), but I've sworn off going to them after [Vans Warped Tour coincided with Ozzfest 1998](/event/1998-07-18), a wonderful show, but just too many bands across too many stages without a good schedule.

<script src="/assets/d3.v7.min.js"></script>
<div id="chart"></div>
<script src="/assets/cumulative-events.js"></script>

<footer>
	<hr class="slender">
	<p style="color:grey"><em>The underlying data is sourced from <a href="https://www.setlist.fm/concerts/rkoopmann">my setlist page</a> and gathered and processed via <a href="/post/2020-04-07/">my setlist.fm.go</a> script. At times, this page may lag behind, but I try to keep it up to date.</em></p>
</footer>

