POSTS = contents/posts.md $(EXTRA_POSTS) $(shell ls -r contents/posts/*/*/*.md)
ABOUT = contents/about.md
TEMPLATES = $(shell ls tpl/*)

# Minimize a HTML file.
#
# 	$(1) - Input
# 	$(2) - Output
#
# Ex. $(call MINIMIZE_HTML,input.html,output.html)
MINIMIZE_HTML = ./node_modules/.bin/html-minifier \
				--output $(2) \
				--minify-js \
				--minify-css \
				--minify-urls \
				--collapse-whitespace \
				--remove-comments \
				--remove-comments-from-cdata \
				--remove-cdatasections-from-cdata \
				$(1)

all: index.html about.html

index.html: min.html
	cp min.html index.html

min.html: draft.html
	$(call MINIMIZE_HTML,$<,$@)

.spell: $(POSTS) $(ABOUT)
	for i in $^; do \
		aspell -c $$i; \
	done
	touch .spell

draft.html: .spell $(POSTS) $(TEMPLATES)
	./scripts/publish.sh $@ $(POSTS)

# Generate about.html from about.md.
# TODO It might be better to move HTML minimization to publish.sh.
about.html: .spell $(ABOUT) $(TEMPLATES)
	./scripts/publish.sh $@ $(ABOUT)

.PHONY: rss
rss: rss/rss.xml

rss/rss.xml: .spell $(POSTS)
	./scripts/rss.sh $@ $(POSTS)

.PHONY: clean
clean:
	rm -f index.html draft.html min.html
