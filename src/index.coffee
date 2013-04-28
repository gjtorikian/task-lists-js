#!/usr/bin/env coffee

cheerio = require 'cheerio'

module.exports = (content) ->
  $ = cheerio.load(content)

  render_item_checkbox = (html, checked) ->
    label = html[3..html.length - 1]
    """
      <label>
        <input type="checkbox"
        class="task-list-item-checkbox"
        #{checked ? 'checked="checked"' : 'checked=""'}/>
        #{label}
      </label>
    """

  listItems = $('li')

  for item in listItems by 1
    srcHtml = $(item).html()

    if /^\[x\]/.test(srcHtml)
      $(item).html(render_item_checkbox(srcHtml, true))
    else if /^\[ \]/.test(srcHtml)
      $(item).html(render_item_checkbox(srcHtml, false))

  $.html()

