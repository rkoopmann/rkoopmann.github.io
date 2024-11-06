---
layout: default
title: artists
permalink: /event/artist/
category: index
---

<style>
div.index-item {
  text-indent: -4.6em !important;
  padding-left: 4.6em !important;
}
</style>

{% assign topArtists = site.data.events.list-artists | where_exp: "e", "e.events.size >= 2" %}


# Artists

## Repeats

Some artists are repeats: {% for e in topArtists %}_[{{ e.artist }}](/event/artist/{{ e.artist | slugify }})_ ({{ e.events.size }}×){% unless forloop.last %}, {% endunless %}{% endfor %}


## Full Listing

Here's the complete listing of artists which I had tickets to attend; Despite my original ticket purchase, I did not attend those formatted as <s>strikethrough</s> for some reason; typically cancelled or postponed events or the artist I was most interested in seeing backed out (I'm looking at you, [Beck](/event/2022-11-13/)).


{% assign items_grouped = site.data.event-artists | group_by_exp: "item", "item.artist | slice: 0, 1 | upcase" %}
{% for g in items_grouped %}
<tt><strong>{{ g.name }}</strong></tt>
  {% assign items = g.items %}
  {% for item in items %}
  <div class="index-item"><span class="post-meta"><tt><a class="post-link" href="/event/artist/{{ item.artist | slugify }}">{{ item.artist }}</a></tt></span></div>
  {% endfor %}
{% endfor %}

<footer>
	<hr class="slender">
	<p style="color:grey"><em>The underlying data is sourced from <a href="https://www.setlist.fm/concerts/rkoopmann">my setlist page</a> and gathered and processed via <a href="/post/2020-04-07/">my setlist.fm.go</a> script. At times, this page may lag behind, but I try to keep it up to date.</em></p>
</footer>
