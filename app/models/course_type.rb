class CourseType < ActiveRecord::Base
  validates_presence_of :full
  validates :abbrev, :uniqueness => {:scope => :full}
end
