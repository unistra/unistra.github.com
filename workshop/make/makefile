SHELL = /usr/bin/zsh

template= template.beamer.latex
chapters = \
    index.md \
    touch.md
components= $(chapters) $(template) prelude.latex deps.pdf deps_with_phony.pdf

mk-slides = pandoc \
    -f markdown -t beamer+escaped_line_breaks \
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


