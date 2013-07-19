class CreateTeachings < ActiveRecord::Migration
  def change
    create_table :teachings do |t|
      t.references :program, index: true
      t.references :teacher, index: true

      t.timestamps
    end
  end
end
