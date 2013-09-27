class CreateCalendarMarkings < ActiveRecord::Migration
  def change
    create_table :calendar_markings do |t|
      t.string :abbrev
      t.string :name

      t.timestamps
    end
  end
end
