---
layout: do-over
permalink: /do-over/examples/
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
