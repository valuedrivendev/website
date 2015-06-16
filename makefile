all: min.html
	cp min.html index.html

min.html: spell
	./node_modules/.bin/html-minifier \
		--output $@ \
		--minify-js \
		--minify-css \
		--minify-urls \
		--collapse-whitespace \
		--remove-comments \
		--remove-comments-from-cdata \
		--remove-cdatasections-from-cdata \
		draft.html

spell: draft.html
	aspell -c $^

draft:
	vim draft.html
