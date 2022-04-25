---
layout: full-width
title: events
permalink: /events/
navigation_weight: 9
category: index
---

{% assign eventList  = site.data.events.list.Event %}
{% assign artistList = site.data.events.list.Event | map: "Artist" | compact | uniq %}
{% assign venueList  = site.data.events.list.Event | map: "Venue"  | compact | uniq %}
{% assign cityList   = site.data.events.list.Event | map: "City"   | compact | uniq %}
{% assign stateList  = site.data.events.list.Event | map: "State"  | compact | uniq %}
{% assign lastShow   = site.data.events.list.Event | first %}
{% assign firstShow  = site.data.events.list.Event | last %}

Some of [my](https://www.setlist.fm/concerts/rkoopmann) concert stats:

- {{ eventList  | size }} performances
- {{ artistList | size }} artists
- {{ venueList  | size }} venues
- {{ cityList   | size }} cities
- {{ stateList  | size }} states
- {{ firstShow  | map: "Date"}} - {{ lastShow | map: "Date" }}

See [details](/events/list).
