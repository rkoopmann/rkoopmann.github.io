---
layout: app
title: do over — text permutations
permalink: /do-over/examples/
app:
  id: 1618131760
  name: do over
  tagline: Like Mail Merge, but for text.
  slug: do-over-text-permutations
  url: do-over

example:
  -
    heading: Simple Index
    description: You can add an index.
    steps:
      -
        values: apple banana coconut
        delimiter: (space)
        template: "?i. ?"
        placeholder: "?"
        joiner: (space)
    result: "1. apple 2. banana 3. coconut"
  -
    heading: Changing Case
    description: You can easily change casing of value elements.
    steps:
      -
        values: APPLE Banana coconut
        delimiter: (space)
        template: "Uppercase: \\U?, Capitalized: \\u?, Lowercase: \\L?"
        placeholder: "?"
        joiner: ;
    result: "Uppercase: APPLE, Capitalized: Apple, Lowercase: apple ; Uppercase: BANANA, Capitalized: Banana, Lowercase: banana ; Uppercase: COCONUT, Capitalized: Coconut, Lowercase: coconut"
  -
    heading: Escaping Placeholders
    description: In the event you need to use the placeholder value in the template itself, you can do so by prefixing the placeholder with `\`.
    steps:
      -
        values: APPLE Banana coconut
        delimiter: (space)
        template: SUM(_) AS var\__i
        placeholder: _
        joiner: ","
    result: "SUM(APPLE) AS var_1 , SUM(Banana) AS var_2 , SUM(coconut) AS var_3"
  -
    heading: Coding 1
    description: Quickly build out where conditions in SQL
    steps:
      -
        values: "apple|coconut|banana"
        delimiter: (pipe)
        template: "([x] IS NOT NULL)"
        placeholder: "[x]"
        joiner: and
    result: "(apple IS NOT NULL) and (banana IS NOT NULL) and (coconut IS NOT NULL)"
  -
    heading: Coding 2
    description: Create new variables in SQL (and adjust the index start)
    steps:
      -
        values: "spend|impressions|clicks|conversions|transactrions|revenue"
        delimiter: (pipe)
        template: "SUM(?) AS fruit_?i \\i-1"
        placeholder: "?"
        joiner: ","
    result: SUM(spend) AS fruit_0 , SUM(impressions) AS fruit_1 , SUM(clicks) AS fruit_2 , SUM(conversions) AS fruit_3 , SUM(transactrions) AS fruit_4 , SUM(revenue) AS fruit_5"
  -
    heading: Chaining Permutations
    description: Feed the output of one permutation into another permutation.
    shortcuts_link: "https://www.icloud.com/shortcuts/2dcec0a841ca49e68a44da686414ffbb"
    steps:
      -
        values: "a b"
        delimiter: (space)
        template: "? != _"
        placeholder: "?"
        joiner: and
      -
        values: "x y"
        delimiter: (space)
        template: <em>step 1 result</em>
        placeholder: _
        joiner: or
    result: "a != x and b != x or a != y and b != y"
---

[appstore]: https://apps.apple.com/us/app/{{ page.app.slug }}/id{{ page.app.id }}

# Examples

{% for ex in page.example %}

### {{ ex.heading }}

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
      <td><code>{{- step.values -}}</code></td>
    </tr>
    <tr>
      <td style="text-align: right">Delimiter</td>
      <td>{{- step.delimiter -}}</td>
    </tr>
    <tr>
      <td style="text-align: right">Template</td>
      <td><code>{{- step.template -}}</code></td>
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
    <tr><th colspan="2">Result</th><td><code>{{- ex.result -}}</code></td></tr>
  </tfoot>
</table>

{% endfor %}
