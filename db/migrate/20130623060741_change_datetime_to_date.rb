class ChangeDatetimeToDate < ActiveRecord::Migration
  def change
    change_table :accomplishments do |t|
      t.date :date
    end

    connection.execute "UPDATE accomplishments SET `date` = DATE(`datetime`)"

    change_table :accomplishments do |t|
      t.remove :datetime
    end
  end
end
