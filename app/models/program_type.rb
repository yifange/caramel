class ProgramType < ActiveRecord::Base
  has_many :programs, :dependent => :restrict_with_exception

  validates_presence_of :name
  validates_uniqueness_of :name

  def self.all_ordered
    ProgramType.all.order("name")
  end

  def self.all_ordered_json
    ProgramType.all_ordered.map do |program_type| 
      {:id => program_type.id, :text => program_type.name}
    end
  end

end
