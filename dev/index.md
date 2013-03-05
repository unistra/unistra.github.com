---
layout: page
title: Dev
group: navigation
---
{% include JB/setup %}

# check 

* specification en json des formulaires: [forms-json-schema](http://daemon.co.za/2012/05/dynamic-forms-json-schema/)
* [backbone forms](https://github.com/powmedia/backbone-forms)

# les langages

## officiels

{% comment %}
{% assign languages_list = 'python|php|java' | split: '|' %}
{% for language in languages_list %}
### [{{language}}]({{language}}) 
{% assign pages_list = site.pages %}
{% assign group = language %}
{% include JB/pages_list %}
{% assign pages_list = site.categories[language] %}
{% include JB/pages_list %}
{% endfor %}
{% endcomment %}

### [python](python) 
<ul>
{% assign pages_list = site.pages %}
{% assign group = 'python' %}
{% include JB/pages_list %}
{% assign pages_list = site.categories.python %}
{% include JB/pages_list %}
</ul>

### [php](php)
<ul>
{% assign pages_list = site.pages %}
{% assign group = 'php' %}
{% include JB/pages_list %}
{% assign pages_list = site.categories.php %}
{% include JB/pages_list %}
</ul>

### [java](java)
<ul>
{% assign pages_list = site.pages %}
{% assign group = 'java' %}
{% include JB/pages_list %}
{% assign pages_list = site.categories.java %}
{% include JB/pages_list %}
</ul>


## de facto

### [perl](perl)
<ul>
{% assign pages_list = site.pages %}
{% assign group = 'perl' %}
{% include JB/pages_list %}
{% assign pages_list = site.categories.perl %}
{% include JB/pages_list %}
</ul>

### [tcl](tcl)
<ul>
{% assign pages_list = site.pages %}
{% assign group = 'tcl' %}
{% include JB/pages_list %}
{% assign pages_list = site.categories.tcl %}
{% include JB/pages_list %}
</ul>

