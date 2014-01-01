class App.ChecklistItemController extends Spine.Controller
  events:
    "change input[type=checkbox]": "toggle"

  elements:
    "input[type=checkbox]": "checkbox"

  constructor: ->
    super
    @item.bind 'ajaxSuccess', @render

  render: =>
    html = JST["checklist/views/checklist_item"]
      item: @item

    @replace html

  toggle: =>
    @item.checked = @checkbox.is(':checked')
    @item.save()
    @el.addClass 'saving'
    false
