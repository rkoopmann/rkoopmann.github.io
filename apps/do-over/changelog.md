---
layout: app
title: do-over Release Notes
permalink: /do-over/changelog/
app:
  id: 1618131760
  name: do over
  tagline: Like Mail Merge, but for text.
  slug: do-over-text-permutations
  url: do-over
---

[appstore]: https://apps.apple.com/us/app/{{ page.app.slug }}/id{{ page.app.id }}

_In addition to feature work, each release addresses some previously-introduced bugs and introduces new bugs; such is software development._

{% assign items_by_year = site.data.app.do-over.changelog | sort: "date" | reverse | group_by_exp: "item", "item.date | date: '%Y'" %}
{% for year in items_by_year %}
<tt><strong>{{ year.name }}</strong></tt>
{% assign items_by_date = year.items | group_by: "date" %}
{% for e in items_by_date %}
{% assign anItem = e.items | first %}
<div class="index-item">⨳ <tt>{{ e.name | date: "%b %d" }}</tt> ⨳ version <em>{{ anItem.version }}</em> ⨳ </div>{% for change in anItem.changes %} <li>{{ change | normalize_whitespace | markdownify | remove: '<p>' | remove: '</p>' }}</li>{% endfor %}
{% endfor %}
{% endfor %}
