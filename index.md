---
layout: full-width
title: home
navigation_weight: 0
---

<style>
div.index-item {
  text-indent: -6em !important;
  padding-left: 6em !important;
}
</style>

Here's some things. Some are stupid.

{% assign posts_by_year = site.posts | group_by_exp: "post", "post.date | date: '%Y'" %}
{% for year in posts_by_year %}
<tt><strong>{{ year.name }}</strong></tt>
  {% for post in year.items %}
  <div class="index-item">⨳ <span class="post-meta"><tt><a class="post-link" href="{{ post.url | relative_url }}">{{ post.date | date: "%b %d" }}</a></tt></span> ⨳ <em>{{ post.title | escape }}</em> ⨳ {{ post.content | number_of_words | divided_by: 250 | floor | plus: 1 }} minute read {% for tag in post.tags %} ⨳ <a class="tag" href="/tag-{{ tag | slugify }}">{{ tag }}</a>{% endfor %} ⨳</div>
  {% endfor %}
{% endfor %}
