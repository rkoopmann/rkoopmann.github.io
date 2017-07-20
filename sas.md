---
layout: category-page
title: sas
permalink: /sas/
navigation_weight: 2
category: index
---

{% for post in site.posts limit:10 %}
{% if post.category == "sas" %}
<div class="Y{{ post.date | date: "%Y" }} M{{ post.date | date: "%m" }}">
	<h2><a class="post-link" href="{{ post.url | relative_url }}">{{ post.title | escape }}</a></h2>
	<span class="post-meta">{{ post.date | date: "%d%b%Y" }}</span>
</div>
{% endif %}
{% endfor %}
