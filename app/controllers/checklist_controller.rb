class ChecklistController < ApplicationController
  # GET /
  def index
    @user = current_user
    @date = today_range.first
  end
end
