class CreateDomains < ActiveRecord::Migration
  def change
    create_table :domains do |t|
      t.references :user, index: true
      t.references :region, index: true

      t.timestamps
    end
  end
end
