class App.User extends Spine.Model
  @configure "user", "email", "score"
  @extend Spine.Model.Ajax
  @url = "/scores"
