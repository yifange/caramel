class CreateAttendenceMarkings < ActiveRecord::Migration
  def change
    create_table :attendence_markings do |t|
      t.string :abbrev
      t.string :full

      t.timestamps
    end
  end
end
