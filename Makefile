OTT_FILES = grammar.ott rules.ott
OTT_OPTS = -tex_show_meta false -tex_wrap false -picky_multiple_parses false -tex_suppress_ntr Q
OTT_TEX = ott.tex

all: combining-logics.pdf combining-logics.html

clean:
	rm -f *.aux *.bbl *.ptb *.pdf *.toc *.out *.run.xml
	rm -f *.log *.bcf *.fdb_latexmk *.fls *.blg
	rm -f combining-logics.pdf
	rm -f combining-logics.lhs
	rm -f combining-logics.tex
	rm -f combining-logics.tar.gz
	rm -f combining-logics.html
	rm -f combining-logics_html.*
	rm -f ott.tex
	rm -f lwarp*
	rm -f *-images.txt
	rm -f *.lwarpmkconf
	rm -f *.cut
	rm -rf sample_project.css
	rm -rf pages

combining-logics.tex: combining-logics.mng $(OTT_FILES)
	ott $(OTT_OPTS) -tex_filter $< $@ $(OTT_FILES)

$(OTT_TEX): $(OTT_FILES)
	ott $(OTT_OPTS) -o $@ $^

%.pdf %.bbl &: %.tex bibliography.bib $(OTT_TEX)
	cd $(dir $<) && latexmk $(notdir $*)

# I have 0 clue why I need to duplicate this rule, but it seems to be
# needed somehow… It may be better to use lwarpmk in latexmk mode
# instead. But it won't make much of a difference. For instance lwarpmk
# won't produce the images with a single invocation.
%_html.tex: %.tex bibliography.bib $(OTT_TEX)
	cd $(dir $<) && latexmk $(notdir $*)

# Additional dependency
%_html.pdf: %.tex

%.html %-images &: %_html.pdf
	cd $(dir $<) && lwarpmk pdftohtml $<
	lwarpmk html1
	lwarpmk limages

continuous::
	ls combining-logics.mng bibliography.bib $(OTT_FILES) | entr make

github-pages:: combining-logics.html lwarp.css combining-logics-images
	mkdir -p pages
	cp -r $^ pages/
	mv pages/combining-logics.html pages/index.html


# .SECONDARY:
# Uncommenting the line above prevents deletion of temporary files, which can be helpful for debugging build problems
