class User < ActiveRecord::Base
  include People
  authenticates_with_sorcery!

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

  has_many :domains
  has_many :regions, through: :domains

  protected
  def self.all_with_region_name(type)
    users = User.all
    users_with_region_name = Hash.new
    users.each do |user|
      if user.type == type
        users_with_region_name[user.id] = []
        user.regions.each do |region|
          users_with_region_name[user.id].push region.name
        end
      end
    end
    users_with_region_name
  end

end
