class App.ScoresController extends Spine.Controller
  constructor: ->
    super
    App.User.bind "refresh", @render
    App.User.fetch()
    App.ChecklistItem.bind "change", ->
      App.User.fetch()

  add_one: (user) =>
    html = JST['checklist/views/score_row']
      user: user

    @append html

  render: =>
    @el.empty()

    App.User.all().forEach @add_one
