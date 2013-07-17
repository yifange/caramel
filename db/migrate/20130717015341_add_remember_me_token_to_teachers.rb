class AddRememberMeTokenToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :remember_me_token, :string, :default => nil
    add_column :teachers, :remember_me_token_expires_at, :datetime, :default => nil

    add_index :teachers, :remember_me_token
  end
end
