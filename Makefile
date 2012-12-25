all: recipes.pdf

recipes.pdf: indices recipe-macros.tex book-format.tex Makefile
	pdflatex -interaction=nonstopmode recipes.tex
	makeindex recipes.idx
	bibtex recipes
	pdflatex -interaction=nonstopmode recipes.tex
	pdflatex -interaction=nonstopmode recipes.tex

indices:
	for f in desserts mains salads breakfasts misc sides soup; do \
		./make-dir $$f > $$f/index.tex; \
	done

# A bit personal to me, maybe I can make this more general some day
web: recipes.pdf
	cp recipes.pdf ~/public_html/purple/jeff/private/recipes.pdf

clean:
	rm -f *.pdf *.log recipes.bbl recipes.blg recipes.idx recipes.ind recipes.toc recipes.ilg *.aux
