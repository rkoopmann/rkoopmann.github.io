#!/bin/bash

input_file="list.json"
output_file="../../events/events.ics"

echo "BEGIN:VCALENDAR
VERSION:2.0
PRODID:A HACK
CALSCALE:GREGORIAN
X-WR-TIMEZONE:America/Chicago
X-WR-CALNAME:Setlist.fm
X-WR-CALDESC:Sourced from selist.fm export
X-WR-RELCALID:8765309E-E4AC-4C2C-B9F1-FF78AB91DA97
X-APPLE-CALENDAR-COLOR:#000080" > "${output_file}"

cat {1,2}*.json | jq -r '. |
"BEGIN:VEVENT
UID:\(.id)
SUMMARY:\(.artist.name)
DTSTART;VALUE=DATE:\(.eventDate | gsub("-"; ""))
DTEND;VALUE=DATE:\(.eventDate | gsub("-"; ""))
URL:\(.url)
LOCATION:\(.venue.name), \(.venue.city.name), \(.venue.city.stateCode)
GEO:\(.venue.city.coords.lat);\(.venue.city.coords.long)
DESCRIPTION:#\(.artist.name | gsub(" "; "-")) #\(.venue.name | gsub(" "; "-"))
END:VEVENT"' | sed "s/$/$CRLF/" >> "${output_file}"

echo "END:VCALENDAR" >> "${output_file}"
