---
layout: full-width
title: events
permalink: /events/
navigation_weight: 40
category: index
---

<style>
div.index-item {
  text-indent: -6em !important;
  padding-left: 6em !important;
}
</style>


{% assign eventList  = site.data.events.list.Event %}
{% assign artistList = site.data.events.list.Event | map: "Artist" | compact | uniq %}
{% assign venueList  = site.data.events.list.Event | map: "Venue"  | compact | uniq %}
{% assign cityList   = site.data.events.list.Event | map: "City"   | compact | uniq %}
{% assign stateList  = site.data.events.list.Event | map: "State"  | compact | uniq %}
{% assign dateList   = site.data.events.list.Event | map: "Date"   | compact | uniq | reverse_sort %}
{% assign lastShow   = site.data.events.list.Event | first %}
{% assign firstShow  = site.data.events.list.Event | last %}

I enjoy a good show and have attended quite a fair number in my youth.
I've got the [tinnitus](https://en.wikipedia.org/wiki/Tinnitus) to prove it.

I didn't do much in terms of keeping track of which concerts I attended and when, let alone who the opening acts were, but I've reconstructed everything before 2010 as best I could.
The 90's remain a bit of a blur.

Here's my listing of {{ eventList | size }} performances from {{ firstShow  | map: "Date" }} - {{ lastShow | map: "Date" }}.
That's {{ dateList   | size }} days at {{ venueList  | size }} venues in {{ cityList   | size }} cities ({{ stateList  | size }} states) involving {{ artistList | size }} artists.

_At times, this page may lag behind my setlist page, but I try to keep it up to date._

For reasons and things, [I create an ICS file of these events](/assets/events-ics-update.sh).
If you're weird, you can [grab a copy](/assets/events.ics)?

{% assign items_by_year = site.data.events.list.Event | group_by_exp: "item", "item.Date | date: '%Y'" %}
{% for year in items_by_year %}
<!-- {{ year }} -->
<tt><strong>{{ year.name }}</strong></tt>
{% assign items_by_date = year.items | group_by: "Date" %}
{% for e in items_by_date %}
{% assign anEvent = e.items | first %}
<div class="index-item">⨳ <span class="post-meta"><tt><a class="post-link" href="/event/{{ e.name }}/">{{ e.name | date: "%b %d" }}</a></tt></span> ⨳ {{ anEvent.Venue }} ⨳ {{ anEvent.City }} ⨳ {{ anEvent.State }} {% for a in e.items %} ⨳ <a href="{{ a.Link }}">{{ a.Artist }}</a>{% endfor %} ⨳</div>
{% endfor %}
{% endfor %}

_Data from [my setlist.fm page](https://www.setlist.fm/concerts/rkoopmann) and gathered through [setlist.fm.go](https://github.com/rkoopmann/setlist.fm.go)._
