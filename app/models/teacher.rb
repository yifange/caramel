class Teacher < User
  has_many :assignments
  has_many :programs, :through => :assignments
end
