class CreateCalendarMarkings < ActiveRecord::Migration
  def change
    create_table :calendar_markings do |t|
      t.string :abbrev
      t.string :full

      t.timestamps
    end
  end
end
