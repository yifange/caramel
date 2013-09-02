class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.references :course, index: true
      t.time :start_time
      t.time :end_time
      t.integer :day_of_week
      t.date :date

      t.timestamps
    end
  end
end
