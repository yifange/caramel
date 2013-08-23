class School < ActiveRecord::Base
  has_many :programs
  has_many :teachers, :through => :programs
  validates_presence_of :abbrev, :full, :region
  validates :abbrev, :uniqueness => {:scope => :full}
  belongs_to :region
  def self.all_ordered
    School.all.order("full")
  end
end
