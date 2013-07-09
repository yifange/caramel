class Calendar < ActiveRecord::Base
  belongs_to :school
  belongs_to :calendar_marking
end
