class Roster < ActiveRecord::Base
  belongs_to :student
  belongs_to :course
  def course_summary
    c = course
    c.id.to_s + " " + c.type
  end
end
