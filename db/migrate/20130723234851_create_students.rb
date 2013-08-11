class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :first_name, :default => nil
      t.string :last_name, :default => nil
      t.references :school, index: true 

      t.timestamps
    end
  end
end
