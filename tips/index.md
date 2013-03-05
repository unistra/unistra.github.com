---
layout: page
title: Tips
header: Posts By Category
group: navigation
---
{% include JB/setup %}

## Tips pages
<ul>
{% assign pages_list = site.pages %}
{% assign group = "tips" %}
{% include JB/pages_list %}
{% assign pages_list = site.categories.tips %}
{% include JB/pages_list %}
</ul>

## Tips categories
{% for category in site.categories %} 
  {% if category[0] | first: == "tips" %}
  <h3 id="{{ category[0] | join: "-" }}-ref">{{ category[0] | join: "/" }}</h3>
  <ul>
    {% assign pages_list = category[1] %}  
    {% include JB/pages_list %}
  </ul>
  {% endif %}
{% endfor %}
