class ProgramType < ActiveRecord::Base
  has_many :programs

  validates_presence_of :full
  validates :abbrev, :uniqueness => {:scope => :full}

  def self.all_ordered
    ProgramType.all.order("full")
  end

  def self.all_ordered_json
    program_types = ProgramType.all.order("full")
    program_types.map do |program_type| 
      {:id => program_type.id, :text => program_type.full}
    end
  end

end
