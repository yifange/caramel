class CreateRosters < ActiveRecord::Migration
  def change
    create_table :rosters do |t|
      t.references :course, index: true
      t.references :enrollment, index: true
      t.references :student, index: true
      t.date :start_date
      t.date :end_date
      t.text :notes

      t.timestamps
    end
  end
end
