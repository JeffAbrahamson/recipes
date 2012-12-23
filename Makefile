all: cover.ps cover.pdf recipes.ps recipes.pdf

recipes.ps: recipes.dvi recipe-macros.tex book-format.tex Makefile
#	dvips -f recipes.dvi -o recipes.ps

#recipes.pdf: recipes.dvi recipe-macros.tex
#	dvipdf -f recipes.dvi -o recipes.pdf
#recipes.pdf: recipes.ps

#cover.pdf: cover.ps

%pdf : %ps
	ps2pdf $< $@

%ps : %dvi
	dvips -f $< -T 5.5in,8.5in -o $@
#	dvips -f $< -o $@

#cover.pdf: cover.dvi
#	dvipdf -f cover.dvi -T 5.5in,8.5in  -o cover.pdf

cover.dvi: cover.tex book-format.tex
	latex -interaction=nonstopmode cover.tex

#recipes.tex:  mains/potato-torte.tex
recipes.dvi: indices recipes.tex recipe-macros.tex */*tex
	latex -interaction=nonstopmode recipes.tex
	makeindex recipes.idx
	bibtex recipes
	latex -interaction=nonstopmode recipes.tex
	latex -interaction=nonstopmode recipes.tex

psbook.ps: recipes.ps
# This doesn't quite work right:
	psbook recipes.ps | psnup -s1 -d -2 -W8.5in -H11in > psbook.ps

indices:
	for f in desserts mains salads breakfasts misc sides soup; do \
		./make-dir $$f > $$f/index.tex; \
	done

bookpages.ps: recipes.ps Makefile
# Compute the number of pages in the book, then select two of each
	./make-book.sh

book.ps: bookpages.ps Makefile cover.ps
	echo; echo; echo "Making book.ps"
	psnup -s1 -2 -pletter bookpages.ps book.ps
	psselect -p1,1 cover.ps covers.ps
	psnup -s1 -2 -pletter covers.ps book-cover.ps

web: recipes.pdf
	cp recipes.pdf ~/public_html/purple/jeff/private/recipes.pdf

clean:
	rm -f *.ps
