# pydelicious Makefile

## Local vars
API = src/__init__.py
TOOLS = tools/dlcs.py tools/optionparse.py #tools/cache.py
RST = README.rst HACKING.rst
REF = $(RST:%.rst=doc/htmlref/%.html) \
	$(TOOLS:tools/%.py=doc/htmlref/%.html) $(API:src/%.py=doc/htmlref/%.html) 
#MAN = doc/man/dlcs.man1.gz

TRGTS := $(REF)
CLN := $(REF) build/ pydelicious*.zip dist *.egg-info

# Docutils flags
DU_GEN = --traceback --no-generator --no-footnote-backlinks --date -i utf-8 -o utf-8
DU_READ = #--no-doc-title
DU_HTML = --no-compact-lists --footnote-references=superscript --cloak-email-addresses #--link-stylesheet --stylesheet=/style/default
DU_XML =


## Default target
# see below for all recipies
.PHONY: help
help:
	@echo "- install: install pydelicious API lib"
	@echo "- doc: build documentation targets"
	@echo "- clean: remove all build targets"
	@echo "- test: run unittests, see tests/main.py"
	@echo "- test-server: run tests against delicious server"
	@echo "- test-all: run all tests"


## Local targets
.PHONY: all test doc install clean clean-setup clean-pyc test-all test-server refresh-test-data zip-all zip-pydelicious

all: test doc

doc: $(REF)
#$(DOC) 
#$(MAN)

#doc/htmlref/%.html: doc/docbook/%.xml # pydoc does text or html, no docbook
#doc/htmlref/dlcs.html: doc/docbook/dlcs.xml
#doc/man/dlcs.man1.gz: doc/docbook/dlcs.xml

test:
	python tests/main.py test_api

test-all:
	python tests/main.py test_all

test-server:
	DLCS_DEBUG=1 python tests/main.py test_server

install:
	python setup.py install
	python setup_tools.py install

clean: clean-setup clean-pyc
	@rm -rf $(CLN)

clean-setup:
	python setup.py clean

clean-pyc:
	-find -name '*.pyc' | xargs rm

refresh-test-data:
	# refetch cached test data to var/
	python tests/pydelicioustest.py refresh_test_data

zip-pydelicous: src/*.py Makefile $(RST) doc/htmlref var/* tests/* setup.py
	zip -9 pydelicious-`python -c "import src;print src.__version__"`.zip $^

zip-all: src/*.py Makefile $(RST) doc/htmlref var/* tests/* tools/* setup.py setup_tools.py
	zip -9 pydelicious+tools-`python -c "import src;print src.__version__"`.zip $^

%.html: %.rst
	@rst2html $(DU_GEN) $(DU_READ) $(DU_HTML) $< $@
	@-tidy -q -m -wrap 0 -asxhtml -utf8 -i $@
	@echo "* $^ -> $@"

doc/htmlref/README.html: README.html
doc/htmlref/HACKING.html: HACKING.html

doc/htmlref/%.html: %.html
	@if test ! -d doc/htmlref; then mkdir doc/htmlref; fi;
	@mv *.html doc/htmlref/
	@echo "* $^ -> $@"

doc/htmlref/__init__.html doc/htmlref/dlcs.html doc/htmlref/optionparse.html: $(API) $(TOOLS)
	@if test ! -d doc/htmlref; then mkdir doc/htmlref; fi;
	@pydoc -w $^
	@mv {dlcs,__init__,optionparse}.html doc/htmlref/
	@echo "* $^ -> $@"

# vim:set noexpandtab:
