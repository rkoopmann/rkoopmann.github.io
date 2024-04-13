---
layout: default
title: tag index
permalink: /tag/
---

# Tag Index

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
{% assign unique_tags = unique_tags | split: "," %}

{% comment %}
Count the number of posts per tag and display
{% endcomment %}
{% for tag in unique_tags %}{% assign tag_count = 0 %}{% for post in site.posts %}{% if post.tags contains tag %}{% assign tag_count = tag_count | plus: 1 %}{% endif %}{% endfor %}<a href="/tag-{{ tag | slugify }}">⨳&nbsp;{{ tag }}</a>&nbsp;({{ tag_count }}){% unless forloop.last %}, {% endunless %}{% endfor %}
