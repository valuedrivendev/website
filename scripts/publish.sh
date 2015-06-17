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

output=$1; shift

echo "Publishing."
echo "  Header"
header > $output
echo "  Posts"
while [ ! -z "$1" ]; do
    echo "$1"
    markdown "$1" >> $output
    shift
done
echo "  Footer"
footer >> $output
