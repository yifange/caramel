class Region < ActiveRecord::Base
  has_many :schools
  has_many :domains
  has_many :users, through: :domains
  validates_presence_of :name
  validates_uniqueness_of :name

  def self.all_ordered_json
    regions = Region.all.order("name")
    regions.map do |region| 
      {:id => region.id, :text => region.name}
    end
  end

  def self.all_ordered
    Region.all.order("name")
  end
end
