class Region < ActiveRecord::Base
  has_many :school

  has_many :domains
  has_many :users, through: :domains
end
