class Habit < ActiveRecord::Base
  attr_accessible :label, :points, :period, :position

  validates_presence_of :label
  validates_presence_of :points
  validates_presence_of :period

  def period_range date=Date.today
    if period == :weekly
      start = date.beginning_of_week(:sunday).midnight()
      (start)..(start + 8.days)
    else
      start = date.midnight()
      start..(start + 2.days)
    end
  end

  def period_enum
    %w{daily weekly}
  end

  def period= val
    raise "Invalid enum value" unless period_enum.member?(val.to_s)
    write_attribute(:period, val)
  end

  def period
    read_attribute(:period).andand.to_sym
  end
end
