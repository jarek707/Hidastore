class App['Plug'] extends Spine.Model
  @configure 'Plug', 'tab_name', 'flags', 'legend', 'parent_id'
  @hasMany 'fields', 'Field'

  @extend Spine.Model.Ajax

window.Plug=App.Plug
