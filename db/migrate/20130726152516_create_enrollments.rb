class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.references :program, index: true
      t.references :student, index: true

      t.timestamps
    end
  end
end
