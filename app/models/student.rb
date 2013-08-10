class Student < ActiveRecord::Base

  include People

  has_many :enrollment

  def self.all_ordered
    users = Student.all.order("first_name")
  end

end
