docker run --platform linux/amd64 --rm --volume="$PWD:/srv/jekyll" -p 4000:4000 jekyll/jekyll:latest jekyll build --drafts --watch
