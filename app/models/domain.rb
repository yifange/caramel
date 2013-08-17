class Domain < ActiveRecord::Base
  belongs_to :user
  belongs_to :region
  validates_presence_of :user
  validates_presence_of :region
end
