---
layout: full-width
title: events
permalink: /events/list
category: index
---

Here's my full listing of concerts as logged on [my setlist.fm page](https://www.setlist.fm/concerts/rkoopmann). At times, this page will lag behind my setlist page, but I try to keep it up to date.

<table>
<thead>
  <tr>
    <th>Date</th>
    <th>Artist</th>
    <th>Venue</th>
    <th>City</th>
    <th>State</th>
  </tr>
</thead>
<tbody>
{% for show in site.data.events.list.Event %}
  <tr>
    <td><a href="{{ show.Link }}">{{ show.Date }}</a></td>
    <td>{{ show.Artist }}</td>
    <td>{{ show.Venue }}</td>
    <td>{{ show.City }}</td>
    <td>{{ show.State }}</td>
  </tr>
{% endfor %}
</tbody>
<tfoot>
  <tr>
    <td>Date</td>
    <td>Artist</td>
    <td>Venue</td>
    <td>City</td>
    <td>State</td>
  </tr>
</tfoot>
</table>

