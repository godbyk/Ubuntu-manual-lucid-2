LATEXFILE=main

SHELL=/bin/bash

all: $(LATEXFILE).pdf

CHAPTERS=\
	frontmatter/*.tex \
	around-desktop/*.tex \
	backmatter/*.tex \
	command-line/*.tex \
	credits/*.tex \
	default-apps/*.tex \
	installation/*.tex \
	learning-more/*.tex \
	prefs-hardware/*.tex \
	prologue/*.tex \
	security/*.tex \
	software-packaging/*.tex \
	troubleshooting/*.tex

$(LATEXFILE).pdf: $(LATEXFILE).tex ubuntu-manual.cls $(CHAPTERS) revinfo
	xelatex --output-driver="xdvipdfmx -V 5" $(LATEXFILE)
	xelatex --output-driver="xdvipdfmx -V 5" $(LATEXFILE)
	makeglossaries -L english $(LATEXFILE)
	makeindex $(LATEXFILE)
	xelatex --output-driver="xdvipdfmx -V 5" $(LATEXFILE)
	makeglossaries -L english $(LATEXFILE)
	xelatex --output-driver="xdvipdfmx -V 5" $(LATEXFILE)
	xelatex --output-driver="xdvipdfmx -V 5" $(LATEXFILE)
	xelatex --output-driver="xdvipdfmx -V 5" $(LATEXFILE)
	$(color_tex) $(LATEXFILE).log

check: $(LATEXFILE).pdf
	$(color_tex) $(LATEXFILE).log

style-guide.pdf: style-guide.tex ubuntu-manual.cls
	xelatex --output-driver="xdvipdfmx -V 5" style-guide
	xelatex --output-driver="xdvipdfmx -V 5" style-guide
	makeglossaries -L english style-guide
	makeindex style-guide
	xelatex --output-driver="xdvipdfmx -V 5" style-guide
	makeglossaries -L english style-guide
	xelatex --output-driver="xdvipdfmx -V 5" style-guide
	xelatex --output-driver="xdvipdfmx -V 5" style-guide
	xelatex --output-driver="xdvipdfmx -V 5" style-guide
	$(color_tex) style-guide.log


# Handle translations
TRANSLATIONS=$(shell for PO in po/*.po; do basename $$PO .po; done) # list of languages in the po/ dir
TRANSLATIONS_TEX=$(foreach PO, $(TRANSLATIONS), ubuntu-manual-$(shell basename $(PO) .po).tex) # list of .tex files to be generated
TRANSLATIONS_PDF=$(foreach PO, $(TRANSLATIONS), ubuntu-manual-$(shell basename $(PO) .po).pdf) # list of .pdf files to be generated

# Default translation is en_US
ubuntu-manual-en_US.pdf: $(LATEXFILE).pdf
	cp $(LATEXFILE).pdf $@

# Compile all translations at once
translations: $(TRANSLATIONS_PDF) ubuntu-manual.cls

LLANG=$(shell echo $${LANG} | sed -e 's/\..*$$//g')
SLANG=$(shell echo $${LANG} | sed -e 's/_.*$$//g')
MYLANG=$(shell for PO in ${TRANSLATIONS}; do if [ "$${PO}" == "${LLANG}" ]; then echo ${LLANG}; exit 0; elif [ "$${PO}" == "${SLANG}" ]; then echo ${SLANG}; exit 0; fi; done; echo "en_US")

# Compile the pdf for the current system language (if there's an appropriate translation)
mylang: ubuntu-manual-${MYLANG}.pdf

ubuntu-manual-%.tex: revinfo
	po4a-translate --master-charset=utf8 -f latex -m main.tex -p $(subst .tex,.po,$(subst ubuntu-manual-,po/,$@)) -l $@ -k 0

#%.tex: %.po ubuntu-manual.cls revinfo
#	po4a-translate --master-charset=utf8 -f latex -m main.tex -p $< -l ubuntu-manual-$(shell basename $< .po).tex -k 0

%.pdf: POLANG=$(shell basename $(subst ubuntu-manual-,,$<) .tex)
%.pdf: TEXFILE=$(shell basename $< .tex)
%.pdf: XINDYLANG=$(shell grep -v "^#" langcodes.txt | grep "^${POLANG}" | awk '{ print $$3 }' || echo -n "general")

%.pdf: %.tex ubuntu-manual.cls revinfo
	#$(call generate_titlepage,${POLANG})
	xelatex --output-driver="xdvipdfmx -V 5" -interaction nonstopmode "\def\polang{${POLANG}}\input{${TEXFILE}}"
	#xelatex --output-driver="xdvipdfmx -V 5" -interaction nonstopmode "\def\polang{${POLANG}}\input{${TEXFILE}}"
	makeglossaries -L english ${TEXFILE}
	makeindex ubuntu-manual-lt
	#texindy -L ${XINDYLANG} -C utf8 ${TEXFILE}.idx
	#xindy -C utf8 -M texindy -L ${XINDYLANG} ${TEXFILE}.idx
	xelatex --output-driver="xdvipdfmx -V 5" -interaction nonstopmode '\def\polang{$(POLANG)}\input{$(TEXFILE)}'
	#makeglossaries -L ${XINDYLANG} $(TEXFILE)
	xelatex --output-driver="xdvipdfmx -V 5" -interaction nonstopmode '\def\polang{$(POLANG)}\input{$(TEXFILE)}'
	xelatex --output-driver="xdvipdfmx -V 5" -interaction nonstopmode '\def\polang{$(POLANG)}\input{$(TEXFILE)}'
	xelatex --output-driver="xdvipdfmx -V 5" -interaction nonstopmode '\def\polang{$(POLANG)}\input{$(TEXFILE)}'
	$(color_tex) $(TEXFILE).log

revinfo:
#	bzr version-info --custom --template="\\\revinfo{{revno}}{{date}}" > revision.tex


#generate_titlepage = \
#	inkscape --export-text-to-path --export-pdf=titlepage/titlepage-$(1).pdf titlepage/titlepage-$(1).svg

#titlepage/titlepage-%.pdf: titlepage/titlepage-%.svg
#	inkscape --export-text-to-path --export-pdf=$(subst .svg,.pdf,$<) $<

#%.pdf: %.asy
#	asy -f pdf $<

#%.pdf: %.svg
#	inkscape --export-text-to-path --export-pdf=$@ $<
	#pdfcrop $@ $@

#%.png: %.dot
#	dot -v -Tpng $< -o $@

#show: $(LATEXFILE).pdf
#	evince $<

#show-mylang: ubuntu-manual-${MYLANG}.pdf
#	evince $<

clean:
	-rm -fr $(LATEXFILE).aux $(LATEXFILE).log $(LATEXFILE).nav $(LATEXFILE).out $(LATEXFILE).pdf $(LATEXFILE).snm $(LATEXFILE).toc
	-rm -fr $(LATEXFILE).idx $(LATEXFILE).ilg $(LATEXFILE).ind $(LATEXFILE).lof $(LATEXFILE).lot
	-rm -fr $(LATEXFILE).glg $(LATEXFILE).glo $(LATEXFILE).gls $(LATEXFILE).xdy
	-rm -f missfont.log
	-rm -f */*.aux
	-rm -f */*.log
	-rm -f *.bbl *.blg */*.bbl */*.blg # biblio files
	-rm -f *.ptc # titletoc
	-rm -f ubuntu-manual-* # translated files


#
# From Chris Monson's LaTeX Makefile
#

SED		?= sed
TPUT	?= tput

tput	= $(shell $(TPUT) $1)

black	:= $(call tput,setaf 0)
red	:= $(call tput,setaf 1)
green	:= $(call tput,setaf 2)
yellow	:= $(call tput,setaf 3)
blue	:= $(call tput,setaf 4)
magenta	:= $(call tput,setaf 5)
cyan	:= $(call tput,setaf 6)
white	:= $(call tput,setaf 7)
bold	:= $(call tput,bold)
uline	:= $(call tput,smul)
reset	:= $(call tput,sgr0)

#
# User-settable definitions
#
LATEX_COLOR_WARNING	?= magenta
LATEX_COLOR_ERROR	?= red
LATEX_COLOR_INFO	?= green
LATEX_COLOR_UNDERFULL	?= magenta
LATEX_COLOR_OVERFULL	?= red bold
LATEX_COLOR_PAGES	?= bold
LATEX_COLOR_BUILD	?= blue
LATEX_COLOR_GRAPHIC	?= yellow
LATEX_COLOR_DEP		?= green
LATEX_COLOR_SUCCESS	?= green bold
LATEX_COLOR_FAILURE	?= red bold

# Gets the real color from a simple textual definition like those above
# $(call get-color,ALL_CAPS_COLOR_NAME)
# e.g., $(call get-color,WARNING)
get-color	= $(subst $(space),,$(foreach c,$(LATEX_COLOR_$1),$($c)))

#
# STANDARD COLORS
#
C_WARNING	:= $(call get-color,WARNING)
C_ERROR		:= $(call get-color,ERROR)
C_INFO		:= $(call get-color,INFO)
C_UNDERFULL	:= $(call get-color,UNDERFULL)
C_OVERFULL	:= $(call get-color,OVERFULL)
C_PAGES		:= $(call get-color,PAGES)
C_BUILD		:= $(call get-color,BUILD)
C_GRAPHIC	:= $(call get-color,GRAPHIC)
C_DEP		:= $(call get-color,DEP)
C_SUCCESS	:= $(call get-color,SUCCESS)
C_FAILURE	:= $(call get-color,FAILURE)
C_RESET		:= $(reset)



color_tex	:= \
	@$(SED) \
	-e '$${' \
	-e '  /^$$/!{' \
	-e '    H' \
	-e '    s/.*//' \
	-e '  }' \
	-e '}' \
	-e '/^$$/!{' \
	-e '  H' \
	-e '  d' \
	-e '}' \
	-e '/^$$/{' \
	-e '  x' \
	-e '  s/^\n//' \
	-e '  /Output written/{' \
	-e '    s/.*(\([^)]\{1,\}\)).*/Success!  Wrote \1/' \
	-e '    s/[[:digit:]]\{1,\}/$(C_PAGES)&$(C_RESET)/g' \
	-e '    s/Success!/$(C_SUCCESS)&$(C_RESET)/g' \
	-e '    b end' \
	-e '  }' \
	-e '  /! *LaTeX Error:.*/{' \
	-e '    s/.*\(! *LaTeX Error:.*\)/$(C_ERROR)\1$(C_RESET)/' \
	-e '    b end' \
	-e '  }' \
	-e '  /.*Warning: Marginpar on page [0-9]\+ moved\./{' \
	-e '    s//$(C_RESET)&$(C_RESET)/' \
	-e '    b end' \
	-e '  }' \
	-e '  /.*Warning: Reference .*/{' \
	-e '    s//$(C_ERROR)&$(C_RESET)/' \
	-e '    b end' \
	-e '  }' \
	-e '  /.*Warning:.*/{' \
	-e '    s//$(C_WARNING)&$(C_RESET)/' \
	-e '    b end' \
	-e '  }' \
	-e '  /Underfull.*/{' \
	-e '    s/.*\(Underfull.*\)/$(C_UNDERFULL)\1$(C_RESET)/' \
	-e '    b end' \
	-e '  }' \
	-e '  /Overfull.*/{' \
	-e '    s/.*\(Overfull.*\)/$(C_OVERFULL)\1$(C_RESET)/' \
	-e '    b end' \
	-e '  }' \
	$(if $(VERBOSE),,-e '  d') \
	-e '  :end' \
	-e '  G' \
	-e '}' \

.PHONY: translations clean show all mylang show-mylang check revinfo

