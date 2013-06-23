class ChecklistController < ApplicationController
  # GET /
  def index
    @user = current_user
    @date_diff = params[:date].to_i || 0
    @date = Date.today + @date_diff
    @prev = date_diff - 1
    @next = date_diff + 1
    @next = nil if @next > 0
  end
end
