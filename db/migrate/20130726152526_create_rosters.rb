class CreateRosters < ActiveRecord::Migration
  def change
    create_table :rosters do |t|
      t.references :student, index: true
      t.references :course, index: true
      t.integer :start_date
      t.integer :end_date

      t.timestamps
    end
  end
end
