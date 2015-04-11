LineFocusStatsView = require './line-focus-stats-view'
{CompositeDisposable} = require 'atom'

module.exports = LineFocusStats =
  lineFocusStatsView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @lineFocusStatsView = new LineFocusStatsView(state.lineFocusStatsViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @lineFocusStatsView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'line-focus-stats:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @lineFocusStatsView.destroy()

  serialize: ->
    lineFocusStatsViewState: @lineFocusStatsView.serialize()

  toggle: ->
    console.log 'LineFocusStats was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
