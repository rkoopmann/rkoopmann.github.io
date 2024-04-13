#!/bin/bash

echo -n  "---
layout: tag_page
tag: ${1/-/ }
permalink: /tag-$1/
---

" > tag-$1.md
