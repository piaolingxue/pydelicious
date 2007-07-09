.PHONY: help clean-pyc pre-dist dist chmodx test dump doc

SRC= pydelicious.py tools/dlcs.py

# Docutils flags
DU_GEN = --traceback --no-generator --no-footnote-backlinks --date -i utf-8 -o utf-8
DU_READ = #--no-doc-title
DU_HTML = --no-compact-lists --footnote-references=superscript --cloak-email-addresses #--link-stylesheet --stylesheet=/style/default 
DU_XML = 

help:
	print "..."

chmodx:
	chmod +x tools/*
	chmod +x tests/*

doc: $(SRC)
	@-mkdir doc
	@-rm doc/*
	-pydoc -w tools/dlcs.py pydelicious 
	@mv {dlcs,pydelicious}.html doc/

test:
	python tests/main.py

clean-pyc:
	-find -path '*.pyc' | xargs rm

pre-dist: clean-pyc chmodx 

dist: doc pre-dist README.xhtml var/file-encodings.tab

var/file-encodings.tab: clean-pyc ./
	-rm $@
	echo "# Have look/guess at file encodings" > $@
	#ufind ./* -maxdepth 2 -type f | xargs file -s > $@
	find . -wholename "./.*" -prune -o \( -wholename "*.svn*" -prune -o -print \) | xargs file -s >> $@

%.xhtml: %.rst
	@rst2html $(DU_GEN) $(DU_READ) $(DU_HTML) $< $@
	@-tidy -q -m -wrap 0 -asxhtml -utf8 -i $@
	@echo "* $^ -> $@"

