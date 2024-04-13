#!/bin/bash

# clear any existing tag pages
rm -f tag-*.md

# fetch a distinct listing of tags being used
tagListing=$(yq '.[] | .tags[] | [.]' ../sitemap.yaml | sed 's/^- //g; s/ /-/g;' | sort -u)

# iterate over tags writing a tag page for each
IFS=$'\n\t' && for tag in ${tagListing}; do
    echo "Refreshing ${tag}"
    echo -n "---
layout: tag_page
tag: ${tag}
permalink: /tag-${tag// /-}/
---

" > tag-${tag// /-}.md
done
