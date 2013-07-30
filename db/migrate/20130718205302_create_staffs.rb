class CreateStaffs < ActiveRecord::Migration
  def change
    create_table :staffs do |t|

      t.timestamps
    end
  end
end
