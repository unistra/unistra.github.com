---
layout: page
title: Documentation
group: navigation
---
{% include JB/setup %}

<ul>
{% assign pages_list = site.pages %}
{% assign group = 'doc' %}
{% include JB/pages_list %}
{% assign pages_list = site.categories.doc %}
{% include JB/pages_list %}
</ul>

