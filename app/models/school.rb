class School < ActiveRecord::Base
  has_many :programs
  validates_presence_of :abbrev, :full, :region
  validates :abbrev, :uniqueness => {:scope => :full}
  belongs_to :region
  def teachers
    teachers = []
    programs.each do |program|
      teachers += program.teachers
    end
    teachers.uniq
  def self.all_ordered
    School.all.order("full")
  end
end
