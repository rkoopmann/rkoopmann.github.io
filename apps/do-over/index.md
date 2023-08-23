---
layout: do-over
title: do over
permalink: /do-over/
---

<!-- screenshots -->

![](./do-over-screens.png)

[![](./Download_on_the_App_Store.svg)][do over]

---

<!-- about -->

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

<!-- app clip -->

**Try it out via an AppClip!** Scan the thingie below for a basic, interactive demo.

![][app-clip]

<!-- examples -->

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

<!-- privacy -->

# Privacy

**Data Collection**

[do over][] does not collect _any_ data.

**Data Sharing**

Given the above point, [do over][] cannot share data. [do over][] is a SwiftUI app and makes use of Apple's developer libraries exclusively; no external libraries. These Apple libraries do not, to the best of my knowledge, collect data.

**Data Retention**

Since [do over][] does not collect data, [do over][] cannot retain data.


---

[do over]: https://apps.apple.com/us/app/do-over-text-permutations/id1618131760
[app-clip]: ./app-clip-code-tagged.svg
