class Calendar < ActiveRecord::Base
  belongs_to :calendar_marking
  belongs_to :school
end
