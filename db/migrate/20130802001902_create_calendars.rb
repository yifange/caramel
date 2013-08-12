class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.date :date
      t.references :term, index: true
      t.time :start_time
      t.time :end_time
      t.references :school, index: true
      t.boolean :available
      t.integer :day_of_week

      t.timestamps
    end
  end
end
