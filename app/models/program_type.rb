class ProgramType < ActiveRecord::Base

  def self.all_ordered
    @program_types = ProgramType.all.order("name ASC")
    @program_types.map do |program_type| 
      {:id => program_type.id, :text => program_type.name}
    end
  end

end
