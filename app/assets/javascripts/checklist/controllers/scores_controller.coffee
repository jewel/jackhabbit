class App.ScoresController extends Spine.Controller
  constructor: ->
    super
    App.User.bind "refresh", @render

    App.ChecklistItem.bind "change:date", @update
    @update(new Date())

  add_one: (user) =>
    html = JST['checklist/views/score_row']
      user: user

    @append html

  render: =>
    @el.empty()

    App.User.all().forEach @add_one

  update: (date) =>
    App.User.fetch
      data: "date=#{date.getTime() / 1000}"
      cache: false
