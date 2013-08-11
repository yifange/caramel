class Attendence < ActiveRecord::Base
  belongs_to :enrollment
  belongs_to :attendence_marking
end
