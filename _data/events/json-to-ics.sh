#!/bin/bash

input_file="list.json"
output_file="../../events/events.ics"

echo "BEGIN:VCALENDAR
VERSION:2.0
PRODID:A HACK
CALSCALE:GREGORIAN
X-WR-TIMEZONE:America/Chicago
X-WR-CALNAME:Setlist.fm
X-WR-CALDESC:Sourced from selist.fm exportInc._products
X-WR-RELCALID:8765309E-E4AC-4C2C-B9F1-FF78AB91DA97
X-APPLE-CALENDAR-COLOR:#000080" > "${output_file}"

cat list.json| jq -r '.[][] | select(.) | . as $i |
"BEGIN:VEVENT
UID:\($i.Id)
SUMMARY:\($i.Artist)
DTSTART;VALUE=DATE:\($i.Date | gsub("-"; ""))
DTEND;VALUE=DATE:\($i.Date | gsub("-"; ""))
URL:\($i.Link)
LOCATION:\($i.City), \($i.State)
DESCRIPTION:#\($i.Artist | gsub(" "; "-")) #\($i.Venue | gsub(" "; "-"))
END:VEVENT"' | sed "s/$/$CRLF/" >> "${output_file}"

echo "END:VCALENDAR" >> "${output_file}"
