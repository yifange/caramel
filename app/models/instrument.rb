class Instrument < ActiveRecord::Base
  has_many :programs, :dependent => :restrict_with_exception
  validates_presence_of :name
  validates_uniqueness_of :name

  def self.all_ordered
    Instrument.all.order("name")
  end

  def self.all_ordered_json 
    Instrument.all_ordered.map do |instrument| 
      {:id => instrument.id, :text => instrument.name}
    end
  end

end
