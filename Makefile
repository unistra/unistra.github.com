export SHELL  = /bin/zsh

depth        ?= .
rc           ?= $(depth)/_build
html_tmpl    ?= $(rc)/template.html

m4path       ?= $(rc)/m4
postdef       = m4 -I$(m4path) post defs render -
m4defs = $(m4path)/defs

pages_src     = $(wildcard *.md )
pages         = $(pages_src:.md=.html)

pandoc  ?= pandoc -Vdepth=$(depth)
pandoc_extensions ?= \
     pipe_tables+grid_tables+multiline_tables+escaped_line_breaks
pandoc_html = $(pandoc) -t html+$(pandoc_extensions)
pandoc_page = $(pandoc_html) --toc -B menu --template $(html_tmpl)

#all: $(pages) look.css behave.js
all: $(pages) look.css

%.html: %.md
	{ $(pandoc_page) |$(postdef)} < $< > $@

%.css: %.us
	stylus -c $<

%.js: %.ls
	lsc -c $<

%.latex %.pdf: %.md
	$(pandoc) -s -t beamer+$(pandoc_extensions) -o $@ $<

$(m4defs): $(rc)/keywords
	perl $(rc)/bin/m4keys  $< > $@
