class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.references :school, index: true
      t.references :instrument, index: true
      t.references :program_type, index: true
      t.references :term, index: true
      t.integer :annual_regular_total
      t.string :annaul_group_total

      t.timestamps
    end
  end
end
