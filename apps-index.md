---
layout: default
title: apps
permalink: /apps/
category: index
navigation_weight: 20
---

<style>
div.index-item {
  text-indent: -4.6em !important;
  padding-left: 4.6em !important;
}
</style>

From 2010 to 2020 or so, I wanted to get into iOS programming; that never really happened. But recently, I've been releasing some apps.

{% assign items_by_year = site.data.apps | sort: "date" | reverse | where: "available", true | group_by_exp: "item", "item.date | date: '%Y'" %}
{% for year in items_by_year %}
  <tt><strong>{{ year.name }}</strong></tt>
  {% assign items_by_date = year.items | group_by: "date" %}
  {% for e in items_by_date %}
    {% assign anItem = e.items | first %}
<div class="index-item"><span class="post-meta"><tt><a class="post-link" href="/{{ anItem.urlSlug }}/">{{ e.name | date: "%b %d" }}</a></tt></span>&mdash;<em>{{ anItem.shortName }}</em>&mdash;{{ anItem.briefDescription | normalize_whitespace | markdownify | remove: '<p>' | remove: '</p>' }}</div>
  {% endfor %}
{% endfor %}
