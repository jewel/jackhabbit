class AddWeeklyHabits < ActiveRecord::Migration
  def change
    add_column :habits, :period, :string
    Habit.connection.execute("update habits set period='daily'")
  end
end
