class InitialSchema < ActiveRecord::Migration
  def change
    create_table :habits do |t|
      t.string :label
      t.integer :points
      t.integer :position
      t.timestamps
    end

    create_table :accomplishments do |t|
      t.references :user
      t.references :habit
      t.datetime :datetime
    end
  end
end
