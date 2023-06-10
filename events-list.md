---
layout: full-width
title: events
permalink: /events/list
category: index
---

Here's my full listing of concerts as logged on [my setlist.fm page](https://www.setlist.fm/concerts/rkoopmann). At times, this page will lag behind my setlist page, but I try to keep it up to date.

<ul style="width:90%">
{% for show in site.data.events.list.Event %}
  <li>
    <a href="{{ show.Link }}">{{ show.Date }}: <em>{{ show.Artist }}</em> @ {{ show.Venue }}, {{ show.City }}, {{ show.State }}</a>
    {% for livestream in site.data.events.livestream.Event %}
      {% if show.Date == livestream.Date %}<em>livestream</em>
      {% endif %}
    {% endfor %}
  </li>
{% endfor %}
</ul>
