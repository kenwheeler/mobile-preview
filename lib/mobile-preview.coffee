MobilePreviewEditorView = require './mobile-preview-editor-view'

module.exports =
  config:
    defaultUrl:
      title: 'Set an URL by default'
      type: 'string'
      default: ''
    keepLastUrl:
      title: 'Remember the last URL used'
      type: 'boolean'
      default: false

  mobilePreviewEditorView: null

  activate: (state) ->
    @mobilePreviewEditorView = new MobilePreviewEditorView(state.mobilePreviewEditorViewState)

  deactivate: ->
    @mobilePreviewEditorView.destroy()

  serialize: ->
    mobilePreviewEditorViewState: @mobilePreviewEditorView.serialize()
