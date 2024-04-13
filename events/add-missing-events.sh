#!/bin/bash

cd ~/dev/rkoopmann.github.io/_events/

dateList=$(jq -r '.[] | .[] | [.Date] | @tsv' ../_data/events/list.json | sort -u)

for d in ${dateList}; do
	y=$(echo "${d}" | cut -d- -f1)
	f="${y}/${d}.md"
	if [ ! -f "${f}" ]; then
	    echo "Adding ${d}"
		mkdir -p "${y}"
		echo -n  "---
layout: event
title: TITLE-GOES-HERE
date: ${d}
tags:
  - event
---

" > "${f}"
	fi
done
