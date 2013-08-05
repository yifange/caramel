class Enrollment < ActiveRecord::Base
  belongs_to :student
  belongs_to :program
  has_many :rosters
  def rosters_by_date(date)
    rosters.select { |r| r.date == date }
  end
  def rosters_by_day_of_week(day_of_week)
    rosters.select { |r| r.day_of_week == day_of_week}
  end
end
