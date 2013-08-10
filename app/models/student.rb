class Student < ActiveRecord::Base
  
  include People

  has_many :enrollment

end
