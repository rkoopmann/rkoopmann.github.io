---
layout: do-over
permalink: /app/do-over/about/
---

# Inspiration & Motivation

In a previous life, I wrote a _lot_ of code in [SAS](https://www.sas.com). One of the gems I came across was the `%do_over` macro created by Ted Clay and [shared with the SAS community](https://support.sas.com/resources/papers/proceedings/proceedings/sugi31/040-31.pdf) back in 2006 ([local copy](./040-31.pdf)). The macros Ted shared streamlined lengthy scripts and made things a _lot_ easier to maintain.

Outside of SAS environment, I frequently found myself wanting to replicate the `%do_over` behavior. But because such integration wasn't possible at runtime, so I turned to being able to at least replicate the functionality to generate the desired code. I turned to one off shell scripts. As one does.

For example, I'd switch over to [CodeRunner](https://coderunnerapp.com) and build out something like this:

```bash
#!/bin/bash

for m in Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec; do
    echo ", ROUND(SUM(${m}), 2) AS ${m}"
done
```

And then copy the results:

```
, ROUND(SUM(Jan), 2) AS Jan
, ROUND(SUM(Feb), 2) AS Feb
, ROUND(SUM(Mar), 2) AS Mar
, ROUND(SUM(Apr), 2) AS Apr
, ROUND(SUM(May), 2) AS May
, ROUND(SUM(Jun), 2) AS Jun
, ROUND(SUM(Jul), 2) AS Jul
, ROUND(SUM(Aug), 2) AS Aug
, ROUND(SUM(Sep), 2) AS Sep
, ROUND(SUM(Oct), 2) AS Oct
, ROUND(SUM(Nov), 2) AS Nov
, ROUND(SUM(Dec), 2) AS Dec
```

Each time I wanted to change something, I spent time going back into CodeRunner, adjusting and tweaking things, rather than actually _doing_ what I needed to get done.

I also wanted to get into Swift programming, so that factored in as well.
