class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.time :start_time
      t.time :end_time
      t.date :date
      t.string :title

      t.timestamps
    end
  end
end
