LineFocusStats = require '../lib/line-focus-stats'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "LineFocusStats", ->
  [workspaceElement, activationPromise] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('line-focus-stats')

  describe "when the line-focus-stats:toggle event is triggered", ->
    it "hides and shows the modal panel", ->
      # Before the activation event the view is not on the DOM, and no panel
      # has been created
      expect(workspaceElement.querySelector('.line-focus-stats')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'line-focus-stats:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(workspaceElement.querySelector('.line-focus-stats')).toExist()

        lineFocusStatsElement = workspaceElement.querySelector('.line-focus-stats')
        expect(lineFocusStatsElement).toExist()

        lineFocusStatsPanel = atom.workspace.panelForItem(lineFocusStatsElement)
        expect(lineFocusStatsPanel.isVisible()).toBe true
        atom.commands.dispatch workspaceElement, 'line-focus-stats:toggle'
        expect(lineFocusStatsPanel.isVisible()).toBe false

    it "hides and shows the view", ->
      # This test shows you an integration test testing at the view level.

      # Attaching the workspaceElement to the DOM is required to allow the
      # `toBeVisible()` matchers to work. Anything testing visibility or focus
      # requires that the workspaceElement is on the DOM. Tests that attach the
      # workspaceElement to the DOM are generally slower than those off DOM.
      jasmine.attachToDOM(workspaceElement)

      expect(workspaceElement.querySelector('.line-focus-stats')).not.toExist()

      # This is an activation event, triggering it causes the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'line-focus-stats:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        # Now we can test for view visibility
        lineFocusStatsElement = workspaceElement.querySelector('.line-focus-stats')
        expect(lineFocusStatsElement).toBeVisible()
        atom.commands.dispatch workspaceElement, 'line-focus-stats:toggle'
        expect(lineFocusStatsElement).not.toBeVisible()
