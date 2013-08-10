class Region < ActiveRecord::Base
  has_many :schools

  has_many :domains
  has_many :users, through: :domains
end
