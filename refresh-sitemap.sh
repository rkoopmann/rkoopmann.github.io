#!/bin/bash

echo "" > _data/sitemap.yaml
for f in $(find . -type f -name "*.md"); do
  # add new file marker
  echo "- file: $f" >> _data/sitemap.yaml

  # append the indented frontmatter
  sed -n '/^---$/,/^---$/p' "$f" \
  | sed '/^---$/d; s/^/  /g' \
  >> _data/sitemap.yaml
done
