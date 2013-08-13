class Course < ActiveRecord::Base
  belongs_to :program
  has_many :rosters
  has_many :students, :through => :rosters
  validate :events_cannot_overlap, :courses_must_in_term, :events_must_in_available_time_slots
  def start_date
    program.start_date
  end
  def end_date
    program.end_date
  end
  def group
    course_type == "GroupCourse"
  end

  def summary
    time_str = start_time.strftime("%I:%M %p") + " - " + end_time.strftime("%I:%M %p")
    if course_type == "GroupCourse"
      ["Group Class", "#{date.strftime("%-d %b")}", time_str]
    else
      ["Regular Class", "#{Date::DAYNAMES[day_of_week]}", time_str]
    end
  end
  private
  def events_must_in_available_time_slots
    available = false
    term_id = program.id
    dummy_start_time = Time.gm(2000, 1, 1, start_time.hour, start_time.min, start_time.sec)
    dummy_end_time = Time.gm(2000, 1, 1, end_time.hour, end_time.min, end_time.sec)
    
    if course_type == "GroupCourse"
      calendars = Calendar.where(:date => date, :term_id => term_id, :available => true)
    else
      calendars = Calendar.where(:day_of_week => day_of_week, :term_id => term_id, :available => true)
    end
    calendars.find_each do |cal|
      if cal[:start_time] <= dummy_start_time and dummy_end_time <= cal[:end_time]
        available = true
        break
      end
    end
    errors.add(:start_time, "must in available time slots") unless available
  end
  def courses_must_in_term
    term = program.term
    if course_type == "GroupCourse"
      unless term.start_date <= date and date <= term.end_date
        errors.add(:date, "must in term")
      end
    end
  end
  def events_cannot_overlap
    @dummy_start_time = Time.gm(2000, 1, 1, start_time.hour, start_time.min, start_time.sec)
    @dummy_end_time = Time.gm(2000, 1, 1, end_time.hour, end_time.min, end_time.sec)
    Course.where(:date => date).find_each do |event|
      if event.id != id and overlap?(event)
        errors.add(:base, "events overlap")
        return
      end
    end
  end
  def start_time_cannot_after_end_time
    if start_time >= end_time
      errors.add(:end_time, "must after start time")
    end
  end
  def overlap?(event)
    if date == event.date and @dummy_end_time > event.start_time and @dummy_start_time < event.end_time
      true
    else
      false
    end
  end
end
