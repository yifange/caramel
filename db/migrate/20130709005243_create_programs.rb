class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.references :school, index: true
      t.references :instrument, index: true
      t.references :course_type, index: true
      t.string :regular_courses_per_week
      t.string :group_courses_per_month

      t.timestamps
    end
  end
end
