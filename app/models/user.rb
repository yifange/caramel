class User < ActiveRecord::Base
  has_many :programs, :through => :registrations
end
