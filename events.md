---
layout: full-width
title: events
permalink: /events/
navigation_weight: 9
category: index
---

I've attended {{ site.data.events.list.Event | size }} performances.

<table>
<thead>
<tr><th>Date</th><th>Artist</th><th>Venue</th></tr>
</thead>
<tbody>
{% for show in site.data.events.list.Event %}
  <tr><td>{{ show.Date }}</td><td>{{ show.Artist }}</td><td>{{ show.Venue }}, {{ show.City }}, {{ show.State }}</td></tr>
{% endfor %}
</tbody>
</table>

