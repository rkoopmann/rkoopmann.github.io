---
layout: full-width
title: eats
permalink: /eat/
navigation_weight: 10
category: index
---

{% for dish in site.eats %}
<div>
	<h2><a class="post-link" href="{{ dish.url | relative_url }}">{{ dish.title | escape }}</a></h2>
</div>
{% endfor %}
