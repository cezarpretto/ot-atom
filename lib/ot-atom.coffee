OtAtomView = require './ot-atom-view'
{CompositeDisposable} = require 'atom'

module.exports = OtAtom =
  otAtomView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @otAtomView = new OtAtomView(state.otAtomViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @otAtomView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'ot-atom:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @otAtomView.destroy()

  serialize: ->
    otAtomViewState: @otAtomView.serialize()

  toggle: ->
    console.log 'OtAtom was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
