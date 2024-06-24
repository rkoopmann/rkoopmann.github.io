#!/bin/bash

function cleanFolder() {
  echo "${FUNCNAME[0]}"
  rm -rf .jekyll-cache
  mkdir .jekyll-cache
  rm -rf _site
  mkdir _site
  echo
}

function processSetlistFiles(){
  echo "${FUNCNAME[0]}"

  cd _data/events
  cat {19,20}*.json | jq -r '{
  date: .eventDate | split("-") | reverse | join("-"),
  venue: {
  name: .venue.name,
  city: .venue.city.name,
  state: .venue.city.state,
  geo: [.venue.city.coords.lat, .venue.city.coords.long],
  url: .venue.url,
  setlist: [.sets.set[] | .song[].name]
  },
  artist: {
  name: .artist.name,
  url: .artist.url
  },
  tour: .tour.name,
  url: .url}' | jq -s . > list-performances.json

  jq -r 'group_by(.date)                 | map({"date":   .[0].date,                 "lineup": .})' list-performances.json > list-dates.json
  jq -r 'group_by(.artist.name)          | map({"artist": .[0].artist.name,          "events": .})' list-performances.json > list-artists.json
  jq -r 'group_by(.lineup[0].venue.name) | map({"venue":  .[0].lineup[0].venue.name, "show":   .})' list-dates.json        > list-venues.json

  cd $pwd
  echo
}

function refreshEventIcs(){
  echo "${FUNCNAME[0]}"

  output_file="assets/events.ics"

  echo "BEGIN:VCALENDAR
VERSION:2.0
PRODID://EPOCHS//setlist
CALSCALE:GREGORIAN
X-WR-TIMEZONE:America/Chicago
X-WR-CALNAME:Setlist.fm
X-WR-CALDESC:Sourced from selist.fm export files
X-WR-RELCALID:8765309E-E4AC-4C2C-B9F1-FF78AB91DA97
X-APPLE-CALENDAR-COLOR:#000080" > "${output_file}"

  cat _data/events/{19,20}*.json | jq -r '. |
"BEGIN:VEVENT
UID:\(.id)
SUMMARY:\(.artist.name)
DTSTAMP;TZID=America/Chicago:\(.eventDate | split("-") | .[2] + .[1] + .[0])T200000
DTSTART;VALUE=DATE:\(.eventDate | split("-") | .[2] + .[1] + .[0])
DTEND;VALUE=DATE:\(.eventDate | split("-") | .[2] + .[1] + .[0])
URL:\(.url)
LOCATION:\(.venue.name), \(.venue.city.name), \(.venue.city.stateCode)
GEO:\(.venue.city.coords.lat);\(.venue.city.coords.long)
DESCRIPTION:#\(.artist.name | gsub("[^A-Za-z0-9 ]"; "") | gsub(" "; "_")) #\(.venue.name | gsub("[^A-Za-z0-9 ]"; "") | gsub(" "; "_")) geo:\(.venue.city.coords.lat),\(.venue.city.coords.long)
END:VEVENT"' | sed "s/$/$CRLF/" >> "${output_file}"
  echo "END:VCALENDAR" >> "${output_file}"

  echo
}

function refreshEventShowPages(){
  echo "${FUNCNAME[0]}"

  xListing=$(jq -r '.[] | .date' _data/events/list-dates.json)

  cd events/show
  # DO NOT CLEAR EXISTING SHOW PAGES. I have upcoming and cancelled shows in there.
  IFS=$'\n\t' && for x in ${xListing}; do
    echo -n "---
layout: event_show_page
date: ${x}
permalink: /event/$x/
---

" > ${x}.md
  done
  cd $pwd

  echo
}

function refreshEventArtistPages(){
  echo "${FUNCNAME[0]}"
  xListing=$(jq -r '.[] | .artist' _data/events/list-artists.json)

  cd events/artist/
  preclean *.md index.md

  IFS=$'\n\t' && for x in ${xListing}; do
    xSlug="$(echo ${x} | tr 'A-Z' 'a-z' | tr ' ' '-' | tr -d "'’" | tr -d '&?!."“”' | sed 's/--/-/g')"
    echo -e "---\nlayout: event_artist_page\nartist: ${x}\npermalink: /event/artist/${xSlug}/\n---\n\n" > ${xSlug}.md
  done
  cd $pwd
  echo
}

function refreshEventVenuePages(){
  echo "${FUNCNAME[0]}"
  xListing=$(jq -r '.[] | .venue' _data/events/list-venues.json)

  cd events/venue
  preclean *.md index.md

  IFS=$'\n\t' && for x in ${xListing}; do
    xSlug="$(echo ${x} | tr 'A-Z' 'a-z' | tr ' ' '-' | tr -d "'’" | tr -d '"“”.')"
    echo -n "---
layout: event_venue_page
venue: ${x}
permalink: /event/venue/${xSlug}/
---

" > ${xSlug}.md
  done
  cd $pwd
  echo
}

function refreshSitemapYaml(){
  echo "${FUNCNAME[0]}"
  echo "" > _data/sitemap.yaml
  for f in $(find . -type f -name "*.md"); do
    echo "- file: $f" >> _data/sitemap.yaml
    sed -n '/^---$/,/^---$/p' "$f" \
    | sed '/^---$/d; s/^/  /g' \
    >> _data/sitemap.yaml
  done
  echo
}

function refreshTags(){
  echo "${FUNCNAME[0]}"
  tagListing=$(yq '.[] | .tags[] | [.]' _data/sitemap.yaml | sed 's/^- //g; s/ /-/g;' | sort -u)

  cd tags
  preclean *.md index.md

  IFS=$'\n\t' && for tag in ${tagListing}; do
    echo -n "---
layout: tag_page
tag: ${tag//-/ }
permalink: /tag/${tag// /-}/
---

" > ${tag// /-}.md
  done
  cd $pwd
  echo
}

function dockerPullRun(){
  echo "${FUNCNAME[0]}"
  docker pull jekyll/jekyll:latest
  docker run \
    --name jekyll \
    --platform linux/amd64 \
    --rm \
    --volume="$PWD:/srv/jekyll" \
    jekyll/jekyll:latest \
    jekyll build --trace --watch
  # bundle exec jekyll build --watch --trace
  echo
}

function preclean() {
  echo "..${FUNCNAME[0]}"
  find . -maxdepth 1 -type f -name "${1:-*.md}"-not -name "${2:-index.md}" -exec rm -f {} \;
}

function main() {
  echo "${FUNCNAME[0]}"

  pwd=$(pwd)
  cleanFolder
  refreshSitemapYaml
  processSetlistFiles
  refreshEventIcs

  ### update assets/list-dates.json for d3 viz
  jq '[reduce .Event[] as $item ({}; .[$item.Date] += [$item.Artist]) | to_entries | sort_by(.key) | .[] | {date: .key, artists: .value | unique}]' _data/events/list.json > assets/list-dates.json

  refreshEventShowPages
  refreshEventArtistPages
  refreshEventVenuePages
  refreshTags
  dockerPullRun
  echo
}

main
