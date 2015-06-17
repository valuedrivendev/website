#!/bin/bash

output=$1; shift

echo "Publishing."
cat > $output << HERE
<?xml version="1.0" ?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
<channel>
  <atom:link href="http://valuedrivendev.com/rss/rss.xml" rel="self" type="application/rss+xml" />
  <title>VDD</title>
  <link>http://valuedrivendev.com/</link>
  <description>It started as a joke.</description>
HERE
echo "  Posts"
while [ ! -z "$1" ]; do
    echo "$1"
    head -n 20 "$1" | sed -n '/^<item/,/^<\/item/p' >> $output
    shift
done
cat >> $output << HERE
</channel>
</rss> 
HERE
