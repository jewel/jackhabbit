class ChecklistController < ApplicationController
  # GET /
  def index
    @user = current_user
  end
end
