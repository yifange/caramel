class Teaching < ActiveRecord::Base
  belongs_to :program
  belongs_to :teacher
end
