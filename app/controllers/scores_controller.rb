class ScoresController < ApplicationController
  def index
    @users = User.all.map do |user|
      data = user.as_json
      data[:score] = 0
      user.accomplishments.each do |acc|
        data[:score] += acc.habit.points
      end
      data
    end
    render json: @users
  end
end
