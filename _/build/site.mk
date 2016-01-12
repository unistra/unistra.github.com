export SHELL  = /bin/zsh

depth            ?= .
builder          ?= $(depth)/_/build
site             ?= $(depth)/_/site
html_tmpl        ?= $(site)/template.html

m4builder        ?= $(builder)/m4
m4site           ?= $(site)/m4
m4defs           ?= $(m4site)/defs
m4               ?= m4 -I $(m4site) -I$(m4builder)
postdef           = $(m4) post defs render -

pages_src         = $(wildcard *.md )
pages             = $(pages_src:.md=.html)

pandoc           ?= pandoc -Vdepth=$(depth)
pandoc_html       = $(pandoc) -t html+$(pandoc_extensions)
pandoc_page       = $(pandoc_html) --toc -B menu --template $(html_tmpl)

pandoc_extensions ?= \
     pipe_tables+grid_tables+multiline_tables+escaped_line_breaks

all: $(pages)
ifndef csub
	for it ($(subdirs)) { \
	    depth=$${it//[^\/]##/..} ;\
	    print "making subdir $$it (depth=$$depth)\n" ;\
	    make -C $$it -f $$depth/Makefile depth=$$depth csub=$$it }
endif

$(pages): $(html_tmpl) $(m4defs) menu

menu: menu.md.
	@ echo update menu
	@ { $(pandoc_html) |$(postdef)} < $< > $@

%.html: %.md
	@ echo update page $@
	@ { $(pandoc_page) |$(postdef)} < $< > $@

%.css: %.us
	stylus -c $<

%.js: %.ls
	lsc -c $<

%.latex %.pdf: %.md
	$(pandoc) -s -t beamer+$(pandoc_extensions) -o $@ $<

$(m4defs): $(site)/keywords
	@ echo update definitions
	@ perl $(builder)/bin/m4keys  $< > $@

