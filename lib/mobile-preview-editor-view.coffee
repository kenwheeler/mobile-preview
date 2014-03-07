{$, EditorView, View} = require 'atom'
MobilePreviewView = require './mobile-preview-view'


module.exports =
class MobilePreviewEditorView extends View
  detaching: false
  mobilePreviewView: null
  @content: ->
    @div class: 'overlay mobile-preview from-top mini', =>
      @subview 'selectEditor', new EditorView(mini: true)
      @div class: 'pull-left', =>
        @button class: 'btn btn-xs', outlet: 'currentButton', 'Current File'
      @div class: 'pull-right', =>
        @button class: 'btn btn-xs', outlet: 'urlButton', 'Open URL'


  initialize: ->
    atom.workspaceView.command "mobile-preview:toggle", => @toggle()
    @urlButton.on 'click', => @confirm()
    @currentButton.on 'click', => @current()
    @on 'core:confirm', => @confirm()
    @on 'core:cancel', => @detach()

  toggle: ->
    if @hasParent()
      @detach()
    else
      if @mobilePreviewView
        @mobilePreviewView.detach()
        @mobilePreviewView.destroy()
      @mobilePreviewView = new MobilePreviewView()
      @attach()

  detach: ->
    return unless @hasParent()
    @detaching = true
    selectEditorFocused = @selectEditor.isFocused
    @selectEditor.setText('')
    super
    @detaching = false

  confirm: ->
    url = @selectEditor.getText()
    url = "http://#{url}" unless /^(http)\S+/.test(url)
    @mobilePreviewView.toggle(url)
    @detach()

  current: ->
    url = atom.workspace.getActiveEditor().getBuffer().file.path
    @mobilePreviewView.toggle(url)
    @detach()

  attach: ->
    atom.workspaceView.append(this)
    @selectEditor.focus()
