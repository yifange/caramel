class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.references :teacher, index: true
      t.references :program, index: true

      t.timestamps
    end
  end
end
