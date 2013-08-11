class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.references :school, index: true
      t.references :instrument, index: true
      t.references :program_type, index: true
      t.references :term, index: true
      t.integer :regular_courses_per_year
      t.string :group_courses_per_year

      t.timestamps
    end
  end
end
