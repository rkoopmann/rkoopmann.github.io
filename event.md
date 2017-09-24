---
layout: full-width
title: events
permalink: /event/
navigation_weight: 9
category: index
---

{% assign coll = site.events | reverse %}
{% for event in coll %}
<div class="Y{{ event.date | date: "%Y" }} M{{ event.date | date: "%m" }}">
	<h2><a class="post-link" href="{{ event.url | relative_url }}">{{ event.title | escape }}</a></h2>
	<span class="post-meta">{{ event.date | date: "%Y %b %d" }}</span>
</div>
{% endfor %}
