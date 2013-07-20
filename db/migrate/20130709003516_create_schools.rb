class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.references :region, index: true
      t.string :abbrev
      t.string :full

      t.timestamps
    end
  end
end
