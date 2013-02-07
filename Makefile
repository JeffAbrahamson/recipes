all: recipes-gs2.pdf recipes-galaxy-tab-10.1.pdf recipes-gs3.pdf recipes-ipad.pdf recipes-iphone4.pdf recipes-iphone5.pdf

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
