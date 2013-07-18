class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.date :date
      t.references :calendar_marking, index: true
      t.time :start_time
      t.time :end_time
      t.references :school, index: true

      t.timestamps
    end
  end
end
