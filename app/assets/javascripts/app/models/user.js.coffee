class App.User extends Spine.Model
  @configure 'User', 'first', 'last', 'email', 'phone', 'group_id'
  @extend Spine.Model.Ajax