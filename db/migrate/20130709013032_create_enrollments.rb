class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.date :start_date
      t.date :end_date
      t.references :course, index: true
      t.references :student, index: true

      t.timestamps
    end
  end
end
