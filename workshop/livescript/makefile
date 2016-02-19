SHELL = /usr/bin/zsh

template= template.beamer.latex
chapters = index.md
components= $(chapters) $(template) prelude.latex deps.pdf deps_with_phony.pdf
pandoc-options= pipe_tables+grid_tables+multiline_tables+escaped_line_breaks
mk-slides = pandoc -f markdown -t beamer+$(pandoc-options) \
    --template $(template)

slides.pdf slides.latex: $(components)
	cat $(chapters) | $(mk-slides) -o $@
	@echo DONE

%.svg: %.dot
	dot -T svg -o $@ $<

%.pdf: %.svg
	rsvg-convert -o $@ < $<

deps.pdf: deps.dot

$(template):
	pandoc -D beamer > $@
