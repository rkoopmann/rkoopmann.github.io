---
layout: default
title: posts
permalink: /post/
navigation_weight: 10
category: index
---

<style>
div.index-item {
  text-indent: -4.6em !important;
  padding-left: 4.6em !important;
}
</style>

Here's some things I've written over the years; Some are good, some are okay, a lot are stupid.

{% assign posts_by_year = site.posts | group_by_exp: "post", "post.date | date: '%Y'" %}
{% for year in posts_by_year %}
<tt><strong>{{ year.name }}</strong></tt>
  {% for post in year.items %}
  <div class="index-item"><span class="post-meta"><tt><a class="post-link" href="{{ post.url | relative_url }}">{{ post.date | date: "%b %d" }}</a></tt></span> &mdash; <em>{{ post.title | escape }}</em>
  {% if post.tags != nil %}
  {% assign theseTags = post.tags | natural_sort %}
  {% for tag in theseTags %}⨳ <em><a href="/tag/{{ tag | slugify }}">{{ tag }}</a></em> {% endfor %} ⨳
  {% endif %}
  </div>
  {% endfor %}
{% endfor %}
