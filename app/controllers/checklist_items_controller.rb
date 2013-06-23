class ChecklistItemsController < ApplicationController
  # GET /checklist_items
  def index
    accomplishments = {}
    date = Date.today
    if params[:date]
      date = Time.at( params[:date].to_i ).to_date
    end

    user = current_user

    @items = Habit.all.map do |habit|
      item = habit.attributes.dup
      item[:checked] = user.accomplished? habit, date
      item[:date] = date
      item
    end

    render json: @items
  end

  # PUT /checklist_items/1
  def update
    habit = Habit.find params[:id]

    date = Date.parse(params[:date])

    action = params[:checked] ? :accomplish! : :unaccomplish!
    current_user.send(action, habit, date)

    head :no_content
  end
end
