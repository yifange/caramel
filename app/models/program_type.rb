class ProgramType < ActiveRecord::Base
  has_many :programs

  validates_presence_of :full
  validates :abbrev, :uniqueness => {:scope => :full}

  def self.all_ordered
    ProgramType.all.order("full")
  end

end
