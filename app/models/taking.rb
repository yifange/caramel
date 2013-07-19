class Taking < ActiveRecord::Base
  belongs_to :program
  belongs_to :student
end
