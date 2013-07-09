class CreateCourseTypes < ActiveRecord::Migration
  def change
    create_table :course_types do |t|
      t.string :abbrev
      t.string :full

      t.timestamps
    end
  end
end
