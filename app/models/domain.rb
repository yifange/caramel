class Domain < ActiveRecord::Base
  belongs_to :user
  belongs_to :region
end
