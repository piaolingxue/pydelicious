# pydelicious Makefile

# Local vars
SRC = pydelicious.py tools/dlcs.py
RST = README.rst HACKING.rst
DOC = $(SRC:%.py=doc/%.html)
HTM = $(RST:%.rst=%.html) 
TRGTS = $(DOC) $(HTM)


# Docutils flags (for *.rst files)
DU_GEN = --traceback --no-generator --no-footnote-backlinks --date -i utf-8 -o utf-8
DU_READ = #--no-doc-title
DU_HTML = --no-compact-lists --footnote-references=superscript --cloak-email-addresses #--link-stylesheet --stylesheet=/style/default
DU_XML =


# Default target
.PHONY: help 
help:
	@echo "No default build targets."
	@echo
	@echo " - doc: build documentation targets"
	@echo " - clean: remove all build targets"
	@echo "	- test: run unittests, see test/main.py"
	@echo " - install: install pydelicious API lib"


# Local targets
.PHONY: doc test install clean all pre-dict clean-pyc test-server

$(HTM): $(RST)

$(DOC): $(SRC)
	pydoc -w tools/dlcs.py pydelicious
	mv {dlcs,pydelicious}.html doc/

doc: $(HTM) $(DOC)

test:
	python tests/main.py test_api

test-server:
	DLCS_DEBUG=1 python tests/main.py test_server

install: 
	python setup.py install

clean: clean-pyc
	rm -rf $(TRGTS)

all: test pre-dist

pre-dist: doc clean-pyc

clean-pyc:
	-find -name '*.pyc' | xargs rm

zip: pydelicious.py $(TRGTS)
	zip -9 pydelicious-0.5.1.zip $^


# Generic targets

%.html: %.rst
	@rst2html $(DU_GEN) $(DU_READ) $(DU_HTML) $< $@
	@-tidy -q -m -wrap 0 -asxhtml -utf8 -i $@
	@echo "* $^ -> $@"


# Non-essential

var/file-encodings.tab: clean-pyc ./
	echo "# Have look/guess at file encodings" > $@
	echo "# BVB: i found this handy to examine the original source files, which used" >> $@
	echo "# non-ASCII encodings. To be removed... sometime." >> $@
	find . -wholename "./.*" -prune -o \( -wholename "*.svn*" -prune -o -type f -print \) | xargs file -s >> $@

