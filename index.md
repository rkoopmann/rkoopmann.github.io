---
layout: default
title: home
permalink: /
navigation_weight: 00
category: index
---

<style>
div.index-item {
  text-indent: -4.6em !important;
  padding-left: 4.6em !important;
}
</style>

{% assign most_recent_posts = site.posts | sort: 'date' | reverse | slice: 0, 10 %}
{% assign most_recent_events = site.data.events.list-dates | sort: 'date' | reverse | slice: 0, 10 %}

{% assign most_recents = most_recent_posts | concat: most_recent_events | sort: 'date' | reverse | slice: 0, 10 %}

{% assign items_by_year = most_recents | sort: 'date' | reverse | group_by_exp: "item", "item.date | date: '%Y'" %}
{% for year in items_by_year %}
  <tt><strong>{{ year.name }}</strong></tt>
  {% assign items_by_date = year.items | group_by: "date" %}
  {% for e in items_by_date %}
    {% assign anItem = e.items | first %}
<div class="index-item">
  {% assign eventDate = anItem.date | date: "%Y-%m-%d" %}
  {% assign eventArtists = site.data.events.list.Event | where_exp: "e", "e.Date == eventDate" | natural_sort: "Artist" %}
  {% assign eventArtistCount = eventArtists | size %}
  {% if eventArtistCount > 0 %}
    <span class="post-meta">
      <tt><a class="post-link" href="/event/{{ anItem.date }}">{{ e.name | date: "%b %d" }}</a></tt>
    </span>
    &mdash;
    {% for a in eventArtists %} ⨳ <a href="/event/artist/{{ a.Artist | slugify }}">{{ a.Artist }}</a>{% endfor %} ⨳
  {% else %}
    <span class="post-meta">
      <tt><a class="post-link" href="{{ anItem.url }}">{{ e.name | date: "%b %d" }}</a></tt>
    </span>
    &mdash;
    <em>{{ anItem.title }}</em>
  {% endif %}
</div>
  {% endfor %}
{% endfor %}
