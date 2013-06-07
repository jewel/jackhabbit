class ApplicationController < ActionController::Base
  protect_from_forgery

  def today_range
    start = Date.today
    finish = Date.today + 2.days

    return start..finish
  end
end
