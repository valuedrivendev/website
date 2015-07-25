#!/bin/bash

# Output filename.
output=$1; shift

log() {
    >&2 echo "$*"
}

combine_posts() {
    # Is this the first article? If so, skip the divider when formatting posts.
    local first_article=1

    log "  Posts"
    while [ ! -z "$1" ]; do
        log "$1"
        if [ $first_article -eq 0 ]; then
            echo "<hr/>"
        elif [ "$1" != "contents/posts.md" ]; then
            # Hack hack. contents/posts.md acts as a container for "stuff I
            # should put before any posts." It's like a prelude, not an article.
            first_article=0
        fi
        markdown "$1"
        shift
    done
}

header() {
    log "  Header"
    cat tpl/header.html
}

footer() {
    log "  Footer"
    cat tpl/footer.html
}

log "Publishing."
header > $output
combine_posts $* >> $output
footer >> $output
