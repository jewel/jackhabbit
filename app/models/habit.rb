class Habit < ActiveRecord::Base
  attr_accessible :label, :points, :period, :position

  validates_presence_of :label
  validates_presence_of :points
  validates_presence_of :period

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

  def period_range date
    if period == :weekly
      start = date.beginning_of_week(:sunday)
      (start)..(start + 6.days)
    else
      start = date
      start..start
    end
  end
end
