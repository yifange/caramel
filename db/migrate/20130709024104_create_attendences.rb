class CreateAttendences < ActiveRecord::Migration
  def change
    create_table :attendences do |t|
      t.references :enrollment, index: true
      t.date :date
      t.references :attendence_marking, index: true

      t.timestamps
    end
  end
end
