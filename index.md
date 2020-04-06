---
layout: full-width
title: home
navigation_weight: 1
---

{% for post in site.posts limit:10 %}
<div class="Y{{ post.date | date: "%Y" }} M{{ post.date | date: "%m" }}">
  <h2><a class="post-link" href="{{ post.url | relative_url }}">{{ post.title | escape }}</a></h2>
  <span class="post-meta">{{ post.date | date: "%Y %b %d" }}</span>
  <span>{{ post.tags }}</span>
  <span>{{ post.content | number_of_words }} words</span>
</div>
{% endfor %}
