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
.PHONY: doc install clean all pre-dict clean-pyc test test-all test-server refresh-test-data

$(HTM): $(RST)

$(DOC): $(SRC)
	pydoc -w tools/dlcs.py pydelicious
	mv {dlcs,pydelicious}.html doc/

doc: $(HTM) $(DOC)

test:
	python tests/main.py test_api

test-all:
	python tests/main.py

test-server:
	DLCS_DEBUG=1 python tests/main.py test_server

refresh-test-data:
	python tests/pydelicioustest.py refresh_test_data

install: 
	python setup.py install

clean: clean-pyc
	rm -rf $(TRGTS) build/ pydelicious-*.zip

all: test pre-dist

pre-dist: doc clean-pyc

clean-pyc:
	-find -name '*.pyc' | xargs rm

zip: pydelicious.py Makefile $(RST) $(TRGTS)
	zip -9 pydelicious-0.5.2-rc1.zip $^


# Generic targets

%.html: %.rst
	@rst2html $(DU_GEN) $(DU_READ) $(DU_HTML) $< $@
	@-tidy -q -m -wrap 0 -asxhtml -utf8 -i $@
	@echo "* $^ -> $@"


