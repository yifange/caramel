class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.belongs_to :program
      t.belongs_to :user

      t.timestamps
    end
  end
end
