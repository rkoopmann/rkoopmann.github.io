---
layout: post
title: Some Jekyll Tools
categories: post
tags:
- bash
- meta
- json
---

Seeing as how a Jekyll site is really just piles of marginally-documented markdown files and json data files, scripting against that pile has some interesting/useful possibilities.

## refresh-sitemap.sh


First off, I wanted to extract the frontmatter from all of the markdown files.
This will dump out the file path along with its frontmatter as-is (minus the frontmatter markers) to a file named `sitemap.yaml`.

This map will get borked if you are one to add a single like consisting of `---` to add horizontal lines in your markdown pages.
(If you add some leading spaces to those lines, this should work fine.)

<script src="https://gist.github.com/rkoopmann/02f441b9dc4d98e38c98b7453b63c7ab.js?file=refresh-sitemap.sh"></script>

## refresh-tag-pages.sh

I try to be consistent and thorough when it comes to tagging, and I think I do a fairly-comprehensive tag normalization on this site.
But I wasn't too confident that (1) I captured all tags and (2) created a tag page for each tag in use.
Tag information is in the frontmatter, which means it's in the sitemap!

I use [`yq`](https://github.com/mikefarah/yq) (think [`jq`](https://github.com/jqlang/jq), but works with .yaml files) to pull a listing of tags being used and create a tag page for each unique tag.

As  yq reads the sitemap, the filter iterates over all files `.[]`, then over all tags `.tags[]`, and outputs each tag `[.]`.
That result is then striped of the leading item marker (`^- `) and sorted uniquely.

Because tags can contain spaces, we have to tell bash to treat new lines as the list item separator in the `for` loop.
Each distinct tag is then slugified on the _permalink_ line and for the output filename.

With the initial `rm` wildcard and subsequent file write, this ensures all used tags have a corresponding tag page.

<script src="https://gist.github.com/rkoopmann/02f441b9dc4d98e38c98b7453b63c7ab.js?file=refresh-tag-pages.sh"></script>

## add-missing-events.sh

This script will look for event dates and add a .md file where the setlist.fm-backed event listing shows entries but there is no corresponding .md file for that date.
I do this so I can talk about the event as a whole rather than individual performances within the event.
So, for example, I can talk about the first time I attended a Flaming Lips show when they were opening up for Candlebox.

<script src="https://gist.github.com/rkoopmann/02f441b9dc4d98e38c98b7453b63c7ab.js?file=add-missing-events.sh"></script>

## refresh-event-things.sh

This script reads the setlist.fm-backed event listing and outputs two grouped listings: one for artist attendances and another for venue attendances.
These lists populate the [top listing table](/events/#top-listing).

<script src="https://gist.github.com/rkoopmann/02f441b9dc4d98e38c98b7453b63c7ab.js?file=refresh-event-things.sh"></script>

## refresh-events-ics.sh

This script converts the main setlist.fm-backed event listing (json) to a valid calendar file (ics).
Nothing too fancy here.

<script src="https://gist.github.com/rkoopmann/02f441b9dc4d98e38c98b7453b63c7ab.js?file=refresh-events-ics.sh"></script>

