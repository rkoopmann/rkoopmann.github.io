#!/bin/bash

function cleanFolder() {
    rm -rf .jekyll-cache
    mkdir .jekyll-cache
    rm -rf _site
    mkdir _site
}
function processSetlistFiles(){
    cat ${d}/{19,20}*.json | jq -r '{
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
    url: .url}' | jq -s . > ${d}/list-performances.json
    ### group json by date & artist
    jq -r 'group_by(.date)        | map({"date":   .[0].date,        "lineup": .})' ${d}/list-performances.json > ${d}/list-dates.json
    jq -r 'group_by(.artist.name) | map({"artist": .[0].artist.name, "events": .})' ${d}/list-performances.json > ${d}/list-artists.json
    jq -r 'group_by(.lineup[0].venue.name)  | map({"venue":  .[0].lineup[0].venue.name,  "show": .})' ${d}/list-dates.json > ${d}/list-venues.json
}
function refreshEventIcs(){
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
cat ${d}/{1,2}*.json | jq -r '. |
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
}
function refreshEventShows(){
# DO NOT CLEAR EXISTING SHOW PAGES. I have cancelled shows in there.
xListing=$(jq -r '.[] | .date' ${d}/list-dates.json)
IFS=$'\n\t' && for x in ${xListing}; do
    echo -n "---
layout: event_show_page
date: ${x}
permalink: /event/$x/
---

" > events/show/${x}.md
done
}
function refreshEventArtists(){
    rm -f events/artist/*.md # pre clean
    xListing=$(jq -r '.[] | .artist' ${d}/list-artists.json)
    IFS=$'\n\t' && for x in ${xListing}; do
        xSlug="$(echo ${x} | tr 'A-Z' 'a-z' | tr ' ' '-' | tr -d "'’" | tr -d '"“”')"
        echo -e "---\nlayout: event_artist_page\nartist: ${x}\npermalink: /event/artist/${xSlug}/\n---\n\n" > events/artist/${xSlug}.md
    done
}
function refreshEventVenues(){
rm -f events/venue/*.md # pre clean
xListing=$(jq -r '.[] | .venue' ${d}/list-venues.json)
IFS=$'\n\t' && for x in ${xListing}; do
    xSlug="$(echo ${x} | tr 'A-Z' 'a-z' | tr ' ' '-' | tr -d "'’" | tr -d '"“”')"
    echo -n "---
layout: event_venue_page
venue: ${x}
permalink: /event/venue/${xSlug}/
---

" > events/venue/${xSlug}.md
done
}
function refreshSitemapYaml(){
    echo "" > _data/sitemap.yaml
    for f in $(find . -type f -name "*.md"); do
      echo "- file: $f" >> _data/sitemap.yaml
      sed -n '/^---$/,/^---$/p' "$f" \
      | sed '/^---$/d; s/^/  /g' \
      >> _data/sitemap.yaml
    done
}
function refreshTags(){
rm -f tag/*.md
tagListing=$(yq '.[] | .tags[] | [.]' _data/sitemap.yaml | sed 's/^- //g; s/ /-/g;' | sort -u)
IFS=$'\n\t' && for tag in ${tagListing}; do
    echo -n "---
layout: tag_page
tag: ${tag//-/ }
permalink: /tag/${tag// /-}/
---

" > tag/${tag// /-}.md
done
}
function dockerPullRun(){
    docker pull jekyll/jekyll:latest
    docker run \
        --name jekyll \
        --platform linux/amd64 \
        --rm \
        --volume="$PWD:/srv/jekyll" \
        jekyll/jekyll:latest \
        jekyll build --trace --watch
    #     bundle exec jekyll build --watch --trace
}

function main() {
    cleanFolder
    processSetlistFiles
    refreshEventIcs
    ### update assets/list-dates.json for d3 viz
    jq '[reduce .Event[] as $item ({}; .[$item.Date] += [$item.Artist]) | to_entries | sort_by(.key) | .[] | {date: .key, artists: .value | unique}]' ${d}/list.json > assets/list-dates.json
    refreshEventShows
    refreshEventArtists
    refreshEventVenues
    refreshTags
    dockerPullRun
}

d="_data/events/"
main
