#!/bin/bash

./refresh-sitemap.sh

docker run \
    --name jekyll \
    --platform linux/amd64 \
    --rm \
    --volume="$PWD:/srv/jekyll" \
    jekyll/jekyll:latest \
    jekyll build --drafts --watch
