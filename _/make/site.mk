export SHELL  = /bin/zsh

depth            ?= .
make_site        ?= $(depth)/_/make
site             ?= $(depth)/_/site
html_tmpl        ?= $(site)/template.html
jade_tmpl=$(shell t=$(html_tmpl); j=$$t:r.jade; test -f $$j && print $$j )

# TODO: probably no by defaut when release public
use-defs         ?= yes

m4make_site      ?= $(make_site)/m4
m4site           ?= $(site)/m4
m4               ?= m4 -I $(m4site) -I$(m4make_site)
postdef           = $(m4) post defs render -

pages_src         = $(wildcard *.md )
pages             = $(pages_src:.md=.html)

pandoc           ?= pandoc -Vdepth=$(depth)
pandoc_html       = $(pandoc) -t html+$(pandoc_extensions) \
		    --highlight-style=kate
pandoc_page       = $(pandoc_html) --toc -B menu --template $(html_tmpl)

pandoc_extensions ?= \
     pipe_tables+grid_tables+multiline_tables+escaped_line_breaks

all: $(pages)

# $(pages): $(html_tmpl) $(m4defs) menu

site: $(pages)
	for it ($(sections)) (cd $$it; make);wait

info:
	@ echo html template: $(html_tmpl)
	@ echo jade template: $(jade_tmpl)
	@ echo options enable:
	@ echo "    defs: $(use-defs)"


$(pages): $(html_tmpl)

ifeq ($(jade_tmpl),)
else
$(html_tmpl): $(jade_tmpl)
	jade.js $<
endif

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

ifdef no-defs

$(m4defs): $(site)/keywords
	@ echo update definitions
	@ perl $(make_site)/bin/m4keys  $< > $@

m4defs  ?= $(m4site)/defs

else
    m4defs =
endif


