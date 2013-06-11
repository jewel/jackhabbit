class App.ChecklistController extends Spine.Controller
  constructor: ->
    super
    App.ChecklistItem.bind "refresh", @add_all
    App.ChecklistItem.fetch()

  add_one: (item) =>
    view = new App.ChecklistItemController
      item: item

    view.render()
    @append view.el

  add_all: =>
    items = App.ChecklistItem.all().sort (a,b) ->
      if a.position > b.position
        return 1
      if a.position < b.position
        return -1
      return 0

    items.forEach @add_one
