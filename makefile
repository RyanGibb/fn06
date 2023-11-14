MARKDOWN = 
MD_FILES = $(shell find static -type f -name '*.md' | grep -v README.md)
HTML_FILES = $(patsubst %.md,%.html,$(MD_FILES))

all: $(HTML_FILES)

clean:
	rm -v $(HTML_FILES)

%.html: %.md makefile includes.yaml scripts/markdown.sh scripts/anchor-links.lua scripts/elem-ids.lua scripts/footnote-commas.lua
	./scripts/markdown.sh $< > $@
