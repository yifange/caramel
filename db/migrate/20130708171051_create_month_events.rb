class CreateMonthEvents < ActiveRecord::Migration
  def change
    create_table :month_events do |t|
      t.datetime :date
      t.string :mark

      t.timestamps
    end
  end
end
