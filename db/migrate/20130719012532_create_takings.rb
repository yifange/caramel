class CreateTakings < ActiveRecord::Migration
  def change
    create_table :takings do |t|
      t.references :program, index: true
      t.references :student, index: true

      t.timestamps
    end
  end
end
