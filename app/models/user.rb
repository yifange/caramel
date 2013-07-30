class User < ActiveRecord::Base
  authenticates_with_sorcery!
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

	def name
		return first_name + ' ' + last_name
	end
end
