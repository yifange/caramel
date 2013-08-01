class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.references :school, index: true
      t.references :instrument, index: true
      t.references :program_type, index: true
      t.integer :regular_course_total
      t.integer :group_course_total
      t.references :term, index: true

      t.timestamps
    end
  end
end
