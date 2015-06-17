POSTS=$(shell ls -r posts/*)
TEMPLATES=$(shell ls tpl/*)

all: draft.html

index.html: min.html
	cp min.html index.html

min.html: draft.html
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

.spell: $(POSTS)
	for i in $(POSTS); do \
		aspell -c $$i; \
	done
	touch .spell

draft.html: .spell $(POSTS) $(TEMPLATES)
	./scripts/publish.sh $@ $(POSTS)
