POSTS=$(shell ls -r posts/*)

all: min.html
	echo 'cp min.html index.html' | at now + 15 min

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

.PHONY: spell
spell: $(POSTS)
	for i in $(POSTS); do \
		aspell -c $$i; \
	done

draft.html: $(POSTS)
	make spell
	./scripts/publish.sh $^
