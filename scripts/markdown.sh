
f=$1

MARKDOWN="pandoc --from markdown+auto_identifiers-smart --to html -s includes.yaml\
	--lua-filter=scripts/anchor-links.lua\
	--lua-filter=scripts/elem-ids.lua\
	--lua-filter=scripts/footnote-commas.lua\
	--citeproc"

$MARKDOWN $f
