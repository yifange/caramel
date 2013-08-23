class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.references :program, index: true
      t.string :course_type
      t.string :name

      t.timestamps
    end
  end
end
