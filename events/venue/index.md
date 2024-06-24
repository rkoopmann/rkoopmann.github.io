---
layout: default
title: venues
permalink: /event/venue/
category: index
---

<style>
div.index-item {
  text-indent: -4.6em !important;
  padding-left: 4.6em !important;
}
</style>

# Venues

## Repeats

{% assign topVenues = site.data.events.list-venues | where_exp: "e", "e.show.size >= 2" %}

{{ topVenues | size }} of the venues are repeats: {% for e in topVenues %}_[{{ e.venue }}](/event/venue/{{ e.venue | slugify }})_ ({{ e.show | size }}×){% unless forloop.last %}, {% endunless %}{% endfor %}

## Full Listing

Here's the complete listing of venues which I had tickets to attend; Despite my original ticket purchase, I did not attend those formatted as <s>strikethrough</s> for some reason; typically cancelled or postponed events or the artist I was most interested in seeing backed out (I'm looking at you, [Beck](/event/2022-11-13/)).

{% assign items_grouped = site.data.event-venues | group_by_exp: "item", "item.venue | slice: 0, 1 | upcase" | sort: "name" %}
{% for g in items_grouped %}
<tt><strong>{{ g.name }}</strong></tt>
  {% assign items = g.items %}
  {% for item in items %}
  <div class="index-item"><span class="post-meta"><tt><a class="post-link" href="/event/venue/{{ item.venue | slugify }}">{{ item.venue }}</a></tt></span></div>
  {% endfor %}
{% endfor %}

<footer>
	<hr class="slender">
	<p style="color:grey"><em>The underlying data is sourced from <a href="https://www.setlist.fm/concerts/rkoopmann">my setlist page</a> and gathered and processed via <a href="/post/2020-04-07/">my setlist.fm.go</a> script. At times, this page may lag behind, but I try to keep it up to date.</em></p>
</footer>
