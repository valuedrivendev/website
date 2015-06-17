#!/bin/bash

combine_posts() {
    cat 
}

header() {
    cat ~/website/tpl/header.html
}

footer() {
    cat ~/website/tpl/footer.html
}

echo "Publishing."
echo "  Header"
header > draft.html
echo "  Posts"
while [ ! -z "$1" ]; do
    echo "$1"
    cat "$1" >> draft.html
    shift
done
echo "  Footer"
footer >> draft.html
