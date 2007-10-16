.PHONY: help clean-pyc pre-dist test doc

SRC= pydelicious.py tools/dlcs.py
RST= README.rst HACKING.rst
XHT= $(RST:%.rst=%.xhtml)

# Docutils flags (for *.rst files)
DU_GEN = --traceback --no-generator --no-footnote-backlinks --date -i utf-8 -o utf-8
DU_READ = #--no-doc-title
DU_HTML = --no-compact-lists --footnote-references=superscript --cloak-email-addresses #--link-stylesheet --stylesheet=/style/default
DU_XML =

help:
	@echo "pydelicious make file"
	@echo "targets:"
	@echo "	- test: run all tests (blackbox API testing and unittests)"
	@echo "	- doc: generate documentation"
	@echo "	- all: all of the previous and clean up *.pyc, generate XHTML from *.rst "
	@echo "don't use make to install! See README"

doc: $(SRC)
	pydoc -w tools/dlcs.py pydelicious
	mv {dlcs,pydelicious}.html doc/

test:
	python tests/main.py

clean-pyc:
	-find -name '*.pyc' | xargs rm

pre-dist: doc clean-pyc $(XHT)

all: test pre-dist

var/file-encodings.tab: clean-pyc ./
	echo "# Have look/guess at file encodings" > $@
	echo "# BVB: i found this handy to examine the original source files, which used" >> $@
	echo "# non-ASCII encodings. To be removed... sometime." >> $@
	find . -wholename "./.*" -prune -o \( -wholename "*.svn*" -prune -o -type f -print \) | xargs file -s >> $@

%.xhtml: %.rst
	@rst2html $(DU_GEN) $(DU_READ) $(DU_HTML) $< $@
	@-tidy -q -m -wrap 0 -asxhtml -utf8 -i $@
	@echo "* $^ -> $@"

