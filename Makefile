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
	rm -f lwarp*

%.tex: %.mng $(OTT_FILES)
	ott $(OTT_OPTS) -tex_filter $< $@ $(OTT_FILES)

$(OTT_TEX): $(OTT_FILES)
	ott $(OTT_OPTS) -o $@ $^

%.pdf %.bbl %_html.tex &: %.tex bibliography.bib $(OTT_TEX)
	cd $(dir $<) && latexmk $(notdir $*)

%.html: %_html.pdf
	cd $(dir $<) && lwarpmk pdftohtml $<

continuous::
	ls combining-logics.mng bibliography.bib $(OTT_FILES) | entr make

# .SECONDARY:
# Uncommenting the line above prevents deletion of temporary files, which can be helpful for debugging build problems
