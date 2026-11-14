all: recipes-nexus9.pdf recipes-nexus5.pdf recipes-ipad.pdf recipes-laptop.pdf

%.pdf: %.tex indices recipe-macros.tex book-format.tex Makefile
	xelatex -interaction=nonstopmode $<
	makeindex $(*F).idx
	bibtex $(*F)
	xelatex -interaction=nonstopmode $<
	xelatex -interaction=nonstopmode $<
	/bin/mv $@ pdf/$@

indices:
	for f in desserts mains salads breakfasts misc sides soup; do \
		./make-dir $$f > $$f/index.tex; \
	done

clean:
	rm -f *.pdf *.log *.bbl *.blg *.idx *.ind *.toc *.ilg *.aux *.out
