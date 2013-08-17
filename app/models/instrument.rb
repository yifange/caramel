class Instrument < ActiveRecord::Base
  has_many :programs
  validates_presence_of :name
  validates_uniqueness_of :name

  def self.all_ordered
    Instrument.all.order("name")
  end

  def self.all_ordered_json 
    instruments = Instrument.all.order("name")
    instruments.map do |instrument| 
      {:id => instrument.id, :text => instrument.name}
    end
  end

end
