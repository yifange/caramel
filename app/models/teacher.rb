class Teacher < User
  authenticates_with_sorcery!

  validates_presence_of :region
  belongs_to :region
end
