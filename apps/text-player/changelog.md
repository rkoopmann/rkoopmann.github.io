---
layout: app
title: text player Release Notes
permalink: /text-player/changelog/
app:
  id: 6479706587
  name: text player
  tagline: Silent Messages, Loud Impact
  slug: text-player
  urlSlug: text-player
---

[appstore]: https://apps.apple.com/us/app/{{ page.app.slug }}/id{{ page.app.id }}

_Each release addresses some previously-introduced bugs and introduces new bugs; such is software development._

{% assign items_by_year = site.data.app.text-player.changelog | sort: "date" | reverse | group_by_exp: "item", "item.date | date: '%Y'" %}
{% for year in items_by_year %}
<tt><strong>{{ year.name }}</strong></tt>
{% assign items_by_date = year.items | group_by: "date" %}
{% for e in items_by_date %}
{% assign anItem = e.items | first %}
<div class="index-item">⨳ <tt>{{ e.name | date: "%b %d" }}</tt> ⨳ version <em>{{ anItem.version }}</em> ⨳ </div>{% for change in anItem.changes %} <li>{{ change | normalize_whitespace | markdownify | remove: '<p>' | remove: '</p>' }}</li>{% endfor %}
{% endfor %}
{% endfor %}
