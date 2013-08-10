class Instrument < ActiveRecord::Base
  has_many :programs

  def self.all_ordered
    @instruments = Instrument.all.order("name ASC")
    @instruments.map do |instrument| 
      {:id => instrument.id, :text => instrument.name}
    end
  end

end
