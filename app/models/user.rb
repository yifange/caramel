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

  def region_ids
    regions.map do |region|
      region.id
    end
  end

  def program_ids
    programs.map do |program|
      program.id
    end
  end

  def regions_ordered_json
    regions_ordered = regions.order("name")
    regions_ordered.map do |region| 
      {:id => region.id, :text => region.name}
    end
  end

  def self.all_ordered(type)
    User.where(:type => type).order("first_name")
  end

  def add_region(region_id)
    Domain.create(user_id: id, region_id: region_id)
  end

  def remove_region(region_id)
    Domain.destroy(Domain.where(:user_id => id, :region_id => region_id))
  end

  def change_region(region_old_id, region_new_id)
    remove_region(region_old_id)
    add_region(region_new_id)
  end

end
