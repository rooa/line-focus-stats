{CompositeDisposable} = require 'atom'
RGBColor = require './RGBColor.js'

module.exports =
class LineFocusStatsView
  constructor: (@editor) ->
    @subscriptions = new CompositeDisposable()
    @markers = []
    @editorView = atom.views.getView @editor

    @init()

    @subscriptions.add @editor.onDidChangeCursorPosition(@cursorMoved)
    # @subscriptions.add @editor.onDidDestroy =>
      # @subscriptions.dispose()

  destroy: ->
    console.log 'destroy'
    @subscriptions.dispose()
    @removeDecorations()

  init: =>
    for line in [0...@editor.getLineCount()]
      @markLine line

  cursorMoved: (event) =>
    console.log 'cursorMoved'
    console.log event.newBufferPosition.row
    line = event.newBufferPosition.row
    color = @editorView.rootElement?.querySelector('.line-number-' + line)?.style.backgroundColor
    console.log color
    try
      color = new RGBColor(color)
      console.log 'parse success'
      console.log color
      color.b = color.b + 10
      if color.b > 255
        color.b = 255
      color = color.toHex()
    catch error
      console.log error
      color = '#000000'
    @editorView.rootElement?.querySelector('.line-number-' + line)?.style.backgroundColor = color
    console.log 'final color is ' + color

  removeDecorations: ->
    return unless @markers?
    marker.destroy() for marker in @markers
    @markers = []

  markLine: (line) ->
    marker = @editor.markBufferPosition([line, 0], invalidate: 'never')
    @editor.decorateMarker(marker, type: 'line-number', class: 'line-focus-stats')
    @editorView.rootElement?.querySelector('.line-number-' + line)?.style.backgroundColor = '#000000'
    @markers.push marker
