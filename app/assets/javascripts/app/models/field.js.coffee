class App.Field extends Spine.Model
  @configure 'Field', 'dom', 'flags', 'xml', 'plug_id', 'label', 'vflag', 'elmtype_id', 'exposure_id', 'seq'
  @belongsTo 'plug', 'App.Plug'

  @extend Spine.Model.Ajax

  destroy: ->
    super

  @updateAttributes: (atts, options) ->
    log  [ atts , options ]
    super
