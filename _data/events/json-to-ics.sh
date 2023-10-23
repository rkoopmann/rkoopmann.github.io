#!/bin/bash

# input_file="list.json"
output_file="../../events/events.ics"

echo "BEGIN:VCALENDAR
VERSION:2.0
PRODID://EPOCHS//setlist
CALSCALE:GREGORIAN
X-WR-TIMEZONE:America/Chicago
X-WR-CALNAME:Setlist.fm
X-WR-CALDESC:Sourced from selist.fm export files
X-WR-RELCALID:8765309E-E4AC-4C2C-B9F1-FF78AB91DA97
X-APPLE-CALENDAR-COLOR:#000080" > "${output_file}"

cat {1,2}*.json | jq -r '. |
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
