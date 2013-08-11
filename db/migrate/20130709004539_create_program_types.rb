class CreateProgramTypes < ActiveRecord::Migration
  def change
    create_table :program_types do |t|
      t.string :abbrev
      t.string :full

      t.timestamps
    end
  end
end
