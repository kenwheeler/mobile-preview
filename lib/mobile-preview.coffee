MobilePreviewEditorView = require './mobile-preview-editor-view'

module.exports =
  mobilePreviewEditorView: null

  activate: (state) ->
    @mobilePreviewEditorView = new MobilePreviewEditorView(state.mobilePreviewEditorViewState)

  deactivate: ->
    @mobilePreviewEditorView.destroy()

  serialize: ->
    mobilePreviewEditorViewState: @mobilePreviewEditorView.serialize()
