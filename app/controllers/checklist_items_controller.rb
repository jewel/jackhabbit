class ChecklistItemsController < ApplicationController
  # GET /checklist_items
  def index
    accomplishments = {}
    date = Date.today
    if params[:date]
      date = Time.at( params[:date].to_i ).to_date
    end

    user = current_user

    other_users = User.all - [current_user]

    @items = Habit.all.map do |habit|
      item = habit.attributes.dup
      item[:checked] = user.accomplished? habit, date
      item[:date] = date
      item[:chain] = user.chain_length habit, date

      item[:others] = other_users.map do |o|
        acc = o.accomplished? habit, date
        len = o.chain_length habit, date
        char = o.email[0].downcase
        char = char.upcase if acc

        if len > 0
          "#{char}#{len}"
        elsif acc
          "#{char}"
        else
          ""
        end
      end.join ""

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
