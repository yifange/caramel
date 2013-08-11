class School < ActiveRecord::Base
  validates_presence_of :abbrev, :full, :region
  validates :abbrev, :uniqueness => {:scope => :full}
  belongs_to :region
  has_many :programs

  def self.all_ordered
    School.all.order("full")
  end
end
