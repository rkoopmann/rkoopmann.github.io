---
title: archive
layout: page
---

{% for post in site.posts limit:10 %}
<div class="Y{{ post.date | date: "%Y" }} M{{ post.date | date: "%m" }}">
	<span class="post-meta">{{ post.date | date: "%Y.%m.%d" }}</span>
	<h2><a class="post-link" href="{{ post.url | relative_url }}">{{ post.title | escape }}</a></h2>
</div>
{% endfor %}
