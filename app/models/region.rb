class Region < ActiveRecord::Base
  has_many :staff
  has_many :teacher
  has_many :school
end
