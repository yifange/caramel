class ProgramType < ActiveRecord::Base
  has_many :programs

  validates_presence_of :name
  validates_uniqueness_of :name

  def self.all_ordered
    ProgramType.all.order("name")
  end

  def self.all_ordered_json
    program_types = ProgramType.all.order("name")
    program_types.map do |program_type| 
      {:id => program_type.id, :text => program_type.name}
    end
  end

end
