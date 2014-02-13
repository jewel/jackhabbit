class App.ScoresController extends Spine.Controller
  constructor: ->
    super
    App.User.bind "refresh", @render

    App.ChecklistItem.bind "change:date", @update
    @update(new Date())

  render: =>
    @el.empty()

    scores = App.User.all().map (user) ->
      user.score

    scores = scores.sort (a,b) -> a - b
    median = scores[Math.floor(scores.length/2)] || 0

    App.User.all().forEach (user) =>
      html = JST['checklist/views/score_row']
        user: user
        median: median

      @append html

  update: (date) =>
    App.User.fetch
      data: "date=#{date.getTime() / 1000}"
      cache: false
