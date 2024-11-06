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

Here's some things; Some are good, some are okay, a lot are stupid.

{% assign posts_by_year = site.posts | group_by_exp: "post", "post.date | date: '%Y'" %}
{% for year in posts_by_year %}
<tt><strong>{{ year.name }}</strong></tt>
  {% for post in year.items %}
  <div class="index-item"><span class="post-meta"><tt><a class="post-link" href="{{ post.url | relative_url }}">{{ post.date | date: "%b %d" }}</a></tt></span>&mdash;<em>{{ post.title | escape }}</em></div>
  {% endfor %}
{% endfor %}


<hr>

{% comment %}
Initialize an empty array to collect tags
{% endcomment %}
{% assign all_tags = "" %}

{% comment %}
Collect all tags from all posts
{% endcomment %}
{% for post in site.posts %}
  {% for tag in post.tags %}
    {% unless all_tags contains tag %}
      {% assign all_tags = all_tags | append: tag | append: "," %}
    {% endunless %}
  {% endfor %}
{% endfor %}

{% comment %}
Split the tags back into an array and remove the last empty item
{% endcomment %}
{% assign all_tags = all_tags | split: "," | sort %}

{% comment %}
Create a unique list of tags
{% endcomment %}
{% assign unique_tags = "" %}
{% for tag in all_tags %}
  {% if tag != "" %}
    {% unless unique_tags contains tag %}
      {% assign unique_tags = unique_tags | append: tag | append: "," %}
    {% endunless %}
  {% endif %}
{% endfor %}
{% assign unique_tags = unique_tags | split: "," | sort_natural %}

{% comment %}
Count the number of posts per tag and display
{% endcomment %}
{%- for tag in unique_tags -%}
  {% assign tag_count = 0 %}
  {%- for post in site.posts -%}
    {% if post.tags contains tag %}
      {% assign tag_count = tag_count | plus: 1 %}
    {% endif %}
  {%- endfor -%}
  <a href="/tag/{{ tag | slugify }}">{{ tag }}</a>&nbsp;({{ tag_count }}){% unless forloop.last %}, {% endunless %}
{%- endfor -%}
