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

  def update_region(region_id)
    delete_regions
    add_region(region_id)
  end

  protected
  def self.all_ordered(type)
    users = User.where(:type => type).order("first_name")
  end

  private
  def delete_regions
    Domain.where(:user_id => id).delete_all
  end

  def add_region(region_id)
    Domain.create(user_id: id, region_id: region_id)
  end

end
