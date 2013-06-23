require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "daily habit" do
    user = users(:cameron)
    date = Date.today
    habit = habits(:brush)
    user.accomplish! habit, date
    assert user.accomplished?(habit, date)
    assert !user.accomplished?(habit, date + 1.day)
    assert !user.accomplished?(habit, date - 1.day)
    user.unaccomplish! habit, date
    assert !user.accomplished?(habit, date)
  end

  test "weekly habit" do
    user = users(:cameron)
    sunday = Date.today.beginning_of_week(:sunday)
    wednesday = sunday + 3.days
    last_saturday = sunday - 1.day
    saturday = sunday + 6.days
    next_sunday = sunday + 7.days

    habit = habits(:dance)
    user.accomplish! habit, wednesday
    assert user.accomplished?(habit, wednesday)
    assert user.accomplished?(habit, sunday)
    assert user.accomplished?(habit, wednesday - 1)
    assert user.accomplished?(habit, wednesday + 1)
    assert user.accomplished?(habit, saturday)
    assert !user.accomplished?(habit, last_saturday)
    assert !user.accomplished?(habit, next_sunday)

    user.unaccomplish! habit, wednesday - 1.days
    assert !user.accomplished?(habit, wednesday)
    assert !user.accomplished?(habit, sunday)
    assert !user.accomplished?(habit, wednesday - 1)
    assert !user.accomplished?(habit, wednesday + 1)
    assert !user.accomplished?(habit, saturday)
  end
end
