class Teacher < User
  has_many :assignments
  has_many :programs, :through => :assignments
  has_many :schools, :through => :programs
  authenticates_with_sorcery!
end
