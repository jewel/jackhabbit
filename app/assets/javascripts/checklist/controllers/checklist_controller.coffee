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
    App.ChecklistItem.each @add_one
