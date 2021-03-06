class Schedule < ActiveRecord::Base
  belongs_to :course
  validates :start_time, :end_time, :date, :presence => true
  validate :events_cannot_overlap, :courses_must_in_term, :events_must_in_available_time_slots, :start_time_cannot_after_end_time
  # validate :no_more_one_schedule_on_one_day
  attr_accessor :recurring, :name, :course_type
  def group
    course.course_type == "GroupCourse"
  end
  
  def save_recurring
    day_of_week = date.wday
    days = Term.find(course.program.term_id).recurring_days(day_of_week, :start_date => date)
    puts days
    r = true
    days.each do |day|
      r = Schedule.new(:date => day, :start_time => start_time, :end_time => end_time, :course_id => course_id).save && r
    end
    # r
  end
  def update_recurring(schedule_params, recurring_type)
    if recurring_type == "all"
      recurring_schedules = Schedule.where(:course_id => course_id)  
    elsif recurring_type == "future"
      recurring_schedules = Schedule.where("course_id = ? AND date >= ? AND start_time >= ?", course_id, date, start_time)
    end
    recurring_schedules.each do |e|
      e.update_attributes(schedule_params)
    end
  end
  def destroy_recurring(recurring_type)
    if recurring_type == "all"
      recurring_schedules = Schedule.where(:course_id => course_id)
    elsif recurring_type == "future"
      recurring_schedules = Schedule.where("course_id = ? AND date >= ? AND start_time >= ?", course_id, date, start_time)
    end
    recurring_schedules.each do |e|
      e.destroy
    end
  end
  private
  def no_more_one_schedule_on_one_day
    if Schedule.where(:course_id => course_id, :date => date).count > 0
      errors.add(:base, "class can only be scheduled once on one day")
    end
  end
  def events_must_in_available_time_slots
    return unless start_time and end_time
    available = false
    term_id = course.program.term_id
    school_id = course.program.school_id
    dummy_start_time = Time.gm(2000, 1, 1, start_time.hour, start_time.min, start_time.sec)
    dummy_end_time = Time.gm(2000, 1, 1, end_time.hour, end_time.min, end_time.sec)
    
    
    calendars = Calendar.where(:date => date, :school_id => school_id, :available => true)
    # calendars = Calendar.where(:date => date, :term_id => term_id, :school_id => school_id, :available => true)
    calendars.find_each do |cal|
      puts dummy_start_time
      puts dummy_end_time
      if cal[:start_time] <= dummy_start_time and dummy_end_time <= cal[:end_time]
        available = true
        break
      end
    end
    errors.add(:base, "must in available time slots") unless available
  end
  def courses_must_in_term
    term = course.program.term
    if course.course_type == "GroupCourse"
      unless term.start_date <= date and date <= term.end_date
        errors.add(:date, "must in term")
      end
    end
  end
  def events_cannot_overlap
    return unless start_time and end_time
    @dummy_start_time = Time.gm(2000, 1, 1, start_time.hour, start_time.min, start_time.sec)
    @dummy_end_time = Time.gm(2000, 1, 1, end_time.hour, end_time.min, end_time.sec)
    program_id = course.program_id

    Schedule.where(:date => date).joins(:course => :program).where({:courses => {:program_id => program_id}}).find_each do |event|
      if event.id != id and overlap?(event)
        errors.add(:base, "time conflicts with schedule #{event.id}")
        return
      end
    end
  end
  def start_time_cannot_after_end_time
    if start_time >= end_time
      errors.add(:base, "end time must after start time")
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
