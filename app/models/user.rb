class User < ActiveRecord::Base

  include People

  authenticates_with_sorcery!

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_uniqueness_of :email

  has_many :domains
  has_many :regions, through: :domains
  accepts_nested_attributes_for :domains

  def update_region(region_id)
    delete_regions
    add_region(region_id)
  end

  def update_regions(region_ids)
    delete_regions
    region_ids.each do |region_id|
      add_region(region_id)
    end
  end

  def regions_ordered_json
    regions_ordered = regions.order("name")
    result = []
    regions_ordered.each do |region| 
      result.push({:id => region.id, :text => region.name})
    end
    result
  end

  def self.all_ordered(type)
    User.where(:type => type).order("first_name")
  end

  def delete_regions
    Domain.where(:user_id => id).delete_all
  end

  def delete_region(region_id)
    Domain.destroy(Domain.where(:user_id => id, :region_id => region_id))
  end

  def add_region(region_id)
    Domain.create(user_id: id, region_id: region_id)
  end

end
