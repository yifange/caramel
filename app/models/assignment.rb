class Assignment < ActiveRecord::Base
  belongs_to :teacher
  belongs_to :program
end
