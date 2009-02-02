# pydelicious Makefile

## Local vars
API = pydelicious.py
TOOLS = tools/dlcs.py tools/optionparse.py tools/cache.py
RST = README.rst HACKING.rst

DOC = $(API:%.py=doc/docbook/%.xml) $(TOOLS:tools/%.py=doc/docbook/%.xml) \
      doc/docbook/index.xml $(RST:%.rst=doc/htmlref/%.html) 
REF = $(DOC:doc/docbook/%.xml=doc/htmlref/%.html) 
MAN = doc/man/dlcs.man1.gz

TRGTS = $(MAN) $(REF) $(DOC)

# Docutils flags
DU_GEN = --traceback --no-generator --no-footnote-backlinks --date -i utf-8 -o utf-8
DU_READ = #--no-doc-title
DU_HTML = --no-compact-lists --footnote-references=superscript --cloak-email-addresses #--link-stylesheet --stylesheet=/style/default
DU_XML =


## Default target
.PHONY: help 
help:
	@echo "No default build targets."
	@echo
	@echo " - doc: build documentation targets"
	@echo " - clean: remove all build targets"
	@echo "	- test: run unittests, see test/main.py"
	@echo " - install: install pydelicious API lib"


## Local targets
.PHONY: doc docbook install clean clean-make clean-setup all pre-dict clean-pyc test test-all test-server refresh-test-data

all: test doc

docbook: $(DOC)

doc: $(MAN) $(REF) $(DOC)

doc/htmlref/dlcs.html: doc/docbook/dlcs.xml

doc/man/dlcs.man1.gz: doc/docbook/dlcs.xml

test:
	python tests/main.py test_api

test-all:
	python tests/main.py

test-server:
	DLCS_DEBUG=1 python tests/main.py test_server

install: 
	python setup.py install

clean: clean-setup clean-pyc clean-make

clean-setup:
	python setup.py clean

clean-make:
	rm -rf $(TRGTS) build/ pydelicious-*.zip

clean-pyc:
	-find -name '*.pyc' | xargs rm

clean-setuptools:
	# cleanup after setuptools..
	rm -rf dist build *.egg-info 	

refresh-test-data:
	# refetch cached test data to var/
	python tests/pydelicioustest.py refresh_test_data

zip: pydelicious.py Makefile $(RST) $(TRGTS) var/* tests/* setup.py
	zip -9 pydelicious-0.5.2-rc1.zip $^ 

# Generic targets

%.xml: %.rst
	@rst2xml $(DU_GEN) $(DU_READ) $(DU_HTML) $< $@
	@echo "* $^ -> $@"

%.html: %.rst
	@rst2html $(DU_GEN) $(DU_READ) $(DU_HTML) $< $@
	@-tidy -q -m -wrap 0 -asxhtml -utf8 -i $@
	@echo "* $^ -> $@"

# dependencies
$(REF): $(DOC)

$(DOC): $(SRC)
	pydoc -w tools/dlcs.py pydelicious
	mv {dlcs,pydelicious}.html doc/

