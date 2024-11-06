---
layout: default
title: shows
permalink: /event/show/
category: index
---

<style>
div.index-item {
  text-indent: -4.6em !important;
  padding-left: 4.6em !important;
}
</style>

## Show Listing

Here's the complete listing of events which I had tickets to attend; Despite my original ticket purchase, I did not attend those formatted as <s>strikethrough</s> for some reason; typically cancelled or postponed events or the artist I was most interested in seeing backed out (I'm looking at you, [Beck](/event/2022-11-13/)).

{% assign items_by_year = site.data.event-shows | group_by_exp: "x", "x.date | date:'%Y'" | reverse %}

{% for year in items_by_year %}
<tt><strong>{{ year.name }}</strong></tt>{% if year.name == "2020" %} &mdash; <em>COVID</em>{% endif %}
  {% assign dates = year.items | reverse %}
  {% for item in dates %}
  {% assign eventDate = item.date | date: "%Y-%m-%d" %}
  {% assign eventArtists = site.data.events.list.Event | where_exp: "e", "e.Date == eventDate" | natural_sort: "Artist" %}
  {% assign eventArtistCount = eventArtists | size %}
  <div class="index-item"><span class="post-meta"><tt><a class="post-link" href="/event/{{ item.date | date: "%Y-%m-%d" }}">{{ item.date | date: "%b %d" }}</a></tt></span> &mdash; {% if eventArtistCount == 0 %}<s>{% endif %}<em>{{ item.show | escape }}</em>{% if eventArtistCount == 0 %}</s>{% endif %}{% if eventArtistCount > 0 %} &mdash; Lineup: {% for a in eventArtists %}{% if eventArtistCount > 1 and forloop.last %}& {% endif %}{{ a.Artist }}{% unless forloop.last %}, {% endunless %}{% endfor %}{% endif %}</div>
  {% endfor %}
{% endfor %}

<footer>
	<hr class="slender">
	<p style="color:grey"><em>The underlying data is sourced from <a href="https://www.setlist.fm/concerts/rkoopmann">my setlist page</a> and gathered and processed via <a href="/post/2020-04-07/">my setlist.fm.go</a> script. At times, this page may lag behind, but I try to keep it up to date.</em></p>
</footer>
