class School < ActiveRecord::Base
  validates_presence_of :abbrev, :full
  validates :abbrev, :uniqueness => {:scope => :full}
end
