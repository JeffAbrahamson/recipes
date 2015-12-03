all: recipes-nexus9.pdf recipes-nexus5.pdf recipes-ipad.pdf recipes-laptop.pdf

%.pdf: %.tex indices recipe-macros.tex book-format.tex Makefile
	pdflatex -interaction=nonstopmode $<
	makeindex $(*F).idx
	bibtex $(*F)
	pdflatex -interaction=nonstopmode $<
	pdflatex -interaction=nonstopmode $<
	mv $@ pdf/$@

indices:
	for f in desserts mains salads breakfasts misc sides soup; do \
		./make-dir $$f > $$f/index.tex; \
	done

# A bit personal to me, maybe I can make this more general some day
web: recipes.pdf
	cp recipes.pdf ~/public_html/purple/jeff/private/recipes.pdf

clean:
	rm -f *.pdf *.log recipes.bbl recipes.blg recipes.idx recipes.ind recipes.toc recipes.ilg *.aux
