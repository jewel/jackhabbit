class ChecklistItemsController < ApplicationController
  # GET /checklist_items
  def index
    accomplishments = {}

    Accomplishment.where(
      user_id: current_user.id,
      datetime: today_range
    ).each do |acc|
      accomplishments[acc.habit_id] = true
    end

    @items = Habit.all.map do |habit|
      item = habit.attributes.dup

      item[:checked] = !!accomplishments[habit.id]

      item
    end

    render json: @items
  end

  # PUT /checklist_items/1
  def update
    habit = Habit.find params[:id]

    accomplishments = Accomplishment.where(
      user_id: current_user.id,
      datetime: today_range,
      habit_id: habit.id
    )

    if params[:checked]
      return head :no_content if accomplishments.count > 0
      acc = Accomplishment.new
      acc.user = current_user
      acc.habit = habit
      acc.datetime = Time.new
      acc.save!
    else
      accomplishments.map &:delete
    end

    head :no_content
  end
end