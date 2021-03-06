#= require spine
#= require spine/manager
#= require spine/ajax
#= require spine/route

#= require_tree ./lib
#= require_self
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views
#= require_tree .

class @App extends Spine.Controller
  constructor: ->
    super

    @checklist = new App.ChecklistController
      el: '#checklist'

    @scores = new App.ScoresController
      el: '#scores'

$ ->
  return unless $('#checklist').length
  window.app = new App()
