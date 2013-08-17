class CreateAttendanceMarkings < ActiveRecord::Migration
  def change
    create_table :attendance_markings do |t|
      t.string :abbrev
      t.string :full

      t.timestamps
    end
  end
end
