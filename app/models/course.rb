class Course < ActiveRecord::Base
  belongs_to :program
  has_many :rosters
  has_many :enrollments, :through => :rosters
  has_many :students, :through => :enrollments
  has_many :schedules
  def start_date
    program.start_date
  end
  def end_date
    program.end_date
  end

  # def summary
  #   time_str = start_time.strftime("%I:%M %p") + " - " + end_time.strftime("%I:%M %p")
  #   if course_type == "GroupCourse"
  #     ["Group Class", "#{date.strftime("%-d %b")}", time_str]
  #   else
  #     ["Regular Class", "#{Date::DAYNAMES[day_of_week]}", time_str]
  #   end
  # end
  # def summary_text
  #   summary[1..-1].join(", ")
  # end
end
