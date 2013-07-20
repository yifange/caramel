class CreateStaffs < ActiveRecord::Migration
  def change
    create_table :staffs do |t|
      t.references :region, index: true

      t.timestamps
    end
  end
end
