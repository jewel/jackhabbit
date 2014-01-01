class ScoresController < ApplicationController
  def index
    date = Date.today
    if params[:date]
      date = Time.at( params[:date].to_i ).to_date
    end

    @users = User.all.map do |user|
      data = user.as_json
      data[:score] = 0
      user.accomplishments.each do |acc|
        last = acc.habit.period_range(acc.date).last
        next if last >= date

        data[:score] += acc.habit.points
      end
      data
    end
    render json: @users
  end
end
