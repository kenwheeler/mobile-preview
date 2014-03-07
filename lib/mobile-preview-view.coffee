{View} = require 'atom'

module.exports =
class MobilePreviewView extends View
  targetUrl: null
  selectView: null
  @content: ->
    @div class: 'mobile-preview tool-panel panel-right', =>
      @div class: 'block', =>
        @button class: 'btn close-button', outlet: 'closeButton', 'Close Preview', =>
      @iframe class: 'web-frame', outlet: 'webFrame', =>
      @div class: 'block', =>
        @button class: 'btn refresh-button', outlet: 'refreshButton', 'Refresh'

  initialize: (serializeState) ->
    @closeButton.on 'click', => @detach()
    @refreshButton.on 'click', => @refresh()
  serialize: -> 

  destroy: ->
    @detach()

  refresh: ->
    if @hasParent()
      @webFrame[0].contentDocument.location.reload()

  toggle: (url) ->
    if @hasParent()
      @detach()
    else
      if url
        @targetUrl = url
        @webFrame.attr('src', url)
        atom.workspaceView.appendToRight(this)
        atom.workspaceView.command "core:save", => @refresh()
