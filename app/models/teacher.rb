class Teacher < User
  validates_presence_of :region
  belongs_to :region
end
