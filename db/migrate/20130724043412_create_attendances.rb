class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.references :roster, index: true
      t.date :date
      t.references :attendance_marking, index: true

      t.timestamps
    end
  end
end
