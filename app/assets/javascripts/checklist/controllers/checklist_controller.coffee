class App.ChecklistController extends Spine.Controller
  events:
    "click .next": "next"
    "click .prev": "prev"

  constructor: ->
    super
    App.ChecklistItem.bind "refresh", @render
    App.ChecklistItem.fetch()
    @date = new Date()

  add_one: (item) =>
    view = new App.ChecklistItemController
      item: item

    view.render()
    @append view.el

  render: =>
    @el.empty()

    items = App.ChecklistItem.all().sort (a,b) ->
      if a.position > b.position
        return 1
      if a.position < b.position
        return -1
      return 0

    items.forEach @add_one

    nav = JST['checklist/views/nav']()

    @append nav

    $('.title-date').text( @date.toDateString() )

  navigate: (offset) =>
    @date.setDate( @date.getDate() + offset )
    App.ChecklistItem.trigger 'change:date', @date
    App.ChecklistItem.fetch
      data: "date=#{Math.round(@date.getTime() / 1000)}"
      cache: false

  next: =>
    @navigate 1

  prev: =>
    @navigate -1
