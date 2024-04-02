---
layout: app
title: do over
permalink: /do-over/
app:
  id: 1618131760
  name: do over
  tagline: text permutations
  slug: do-over-text-permutations
---

[appstore]: https://apps.apple.com/us/app/{{ pager.app.slug }}/id{{ page.app.id }}


![](./do-over-screens.png)

[![](./Download_on_the_App_Store.svg)][do over]

---

- Want to quickly create some similar text without manually typing everything out? do over can do that.
- Want to quickly and easily change the values and see the results in realtime? do over can do that.
- Want to use a different placeholder in the template? do over can do that.
- Want to see how the merged results will look using different joins? do over can do that.
- Want to be successful in life? do over, unfortunately, cannot do that.
- Want to unknowingly share your data with who-knows-who? do over [can't help you with that](./privacy/).

Provide a list of values (`apple banana coconut … zucchini`, for example) along with a template to use (such as `?i. ?`), and do over generates merged output:

    1. apple
    2. banana
    3. coconut
    …
    26. zucchini

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

---

# AppClip

**Try it out via an AppClip!** Scan the thingie below for a basic, interactive demo.

![][app-clip]

---

# Shortcuts

Version 1.4 introduces two Shortcuts.app actions:

- Permutate Text - runs the basic permutations. helper functions (e.g., \days, \help, \1-5) are not available in this action.
- Resolve Range - resolves ranges (e.g., -10--4, 1-5).

As with most things in Shortcuts.app, you can feed output from one action as a parameter into another action. For example, [this](https://www.icloud.com/shortcuts/2dcec0a841ca49e68a44da686414ffbb) shortcut:

![](./shortcut-chaining-permutations.jpeg){: width="250" }

---

# Examples

{% for ex in site.data.app.do-over.examples %}

## {{ ex.heading }}

{{ ex.description }} {% if ex.shortcuts_link %}_[Here]({{- ex.shortcuts_link -}}) is a shortcut demonstrating this._{% endif %}

<table>
  <thead>
    <tr>
      <th colspan="2">Action/Field</th>
      <th>Value/Setting</th>
    </tr>
  </thead>
  {% for step in ex.steps %}
  <tbody>
    <tr>
      <th colspan="3"></th>
    </tr>
    <tr>
      <th rowspan="5">S<br>T<br>E<br>P<br><br>{{- forloop.index -}}</th>
      <td style="text-align: right">Values</td>
      <td><pre>{{- step.values -}}</pre></td>
    </tr>
    <tr>
      <td style="text-align: right">Delimiter</td>
      <td>{{- step.delimiter -}}</td>
    </tr>
    <tr>
      <td style="text-align: right">Template</td>
      <td><pre>{{- step.template -}}</pre></td>
    </tr>
    <tr>
      <td style="text-align: right">Placeholder</td>
      <td>{{- step.placeholder -}}</td>
    </tr>
    <tr>
      <td style="text-align: right">Joiner</td>
      <td>{{- step.joiner -}}</td>
    </tr>
  </tbody>
  {% endfor %}
  <tfoot>
    <tr><th colspan="2">Result</th><td><pre>{{- ex.result -}}</pre></td></tr>
  </tfoot>
</table>

{% endfor %}

---

# Terms

Feel free to use [{{ page.app.name }}][appstore] at your leisure for whatever purpose you have in mind.

**Refunds**

All [{{ page.app.name }}][appstore] purchases are final. I cannot issue refunds charged to your Apple ID, but you can ask [Apple](https://support.apple.com/en-us/118223) to do so.

---

# Privacy

**Data Collection**

[{{ page.app.name }}][appstore] does not collect _any_ data.

**Data Sharing**

Given the above point, [{{ page.app.name }}][appstore] cannot share data. [{{ page.app.name }}][appstore] is a SwiftUI app and makes use of Apple's developer libraries exclusively; no external libraries. These Apple libraries do not, to the best of my knowledge, collect data.

**Data Retention**

Since [{{ page.app.name }}][appstore] does not collect data, [{{ page.app.name }}][appstore] cannot retain data.

---

# Support

_do over_ is organized into the following sections:

- **Values** is the place to enter your variables. The adjacent settings button lets you make changes to these raw values.
- **Result** shows the resulting permutation. The adjacent settings button lets you take actions on the result, including pipine back into the **Values** section.
- **Settings** is the place to make adjustments to underlying permutation settings.
    - _Values_ allows you to specify the value list delimiter to use. The adjacent settings button allows you to quickly clear the delimiter (Using an empty value delimiter will split the Values at each character) and, if you're on iOS, offer to insert the tab character in the delimiter field.
    - _Template_ is where you specify the pattern to riff on and what token the pattern represents where the value item goes. The adjacent settings button offers some quick actions as well as inserting the flags for changing casings.
    - _Result_ is where you specify the permutation join string. The adjacent settings button offers some quick actions.
- **About**
    - _Help_ offers some helpful things.
    - _Miscellaneous Debris_ is my nod to Primus and some self-serving links.
    - _Do Over_ offers some user actions and technical information related to the app.

There's not much that can go wrong with [{{ page.app.name }}][appstore]. That said, if after restarting your device and reproducing the issue you think you've found a bug, please reach out; I don't like bugs either.


---

[do over]: https://apps.apple.com/us/app/do-over-text-permutations/id1618131760
[app-clip]: ./app-clip-code-tagged.svg
