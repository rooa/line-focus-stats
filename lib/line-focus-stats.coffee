LineFocusStatsView = require './line-focus-stats-view'

module.exports = LineFocusStats =
  lineFocusStatsViews: null

  activate: (state) ->
    console.log 'activate LineFocusStats'
    @lineFocusStatsViews = []

    atom.commands.add 'atom-workspace',
      'line-focus-stats:toggle': => @toggle()

    # @enable()

  deactivate: ->
    @disable()

  enable: ->
    @enabled = true

    atom.workspace.observeTextEditors (editor) =>
      @lineFocusStatsViews.push(new LineFocusStatsView(editor))

  disable: ->
    while lineFocusStatsView = @lineFocusStatsViews.shift()
      lineFocusStatsView.destroy()

    @enabled = false

  toggle: ->
    console.log 'LineFocusStats was toggled!'
    if @enabled
      @disable()
    else
      @enable()
