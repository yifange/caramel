class Schedule < ActiveRecord::Base
  belongs_to :course
  validate :events_cannot_overlap, :courses_must_in_term, :events_must_in_available_time_slots

  def group
    course.course_type == "GroupCourse"
  end

  def save_recurring
    if course.course_type == "RegularCourse"
      day_of_week = date.wday
      days = Term.find(course.program.term_id).recurring_days(day_of_week, :start_date => date)
      r = true
      days.each do |day|
        r = r && Schedule.new(:date => day, :start_time => start_time, :end_time => end_time, course_id => course_id)
      end
    end
  end
  def update_recurring(schedule_params)
    recurring_schedules = Schedule.where(:course_id => schedule_params[:schedule][:course_id])  
    recurring_schedules.each do |e|
      e.update_attributes(schedule_params)
    end
  end
  def destroy_recurring
    recurring_schedules = Schedule.where(:course_id => schedule_params[:schedule][:course_id])
    recurring_schedules.each do |e|
      e.destroy
    end
  end
  private
  def events_must_in_available_time_slots
    available = false
    term_id = course.program.id
    dummy_start_time = Time.gm(2000, 1, 1, start_time.hour, start_time.min, start_time.sec)
    dummy_end_time = Time.gm(2000, 1, 1, end_time.hour, end_time.min, end_time.sec)
    
    if course.course_type == "GroupCourse"
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
    term = course.program.term
    if course.course_type == "GroupCourse"
      unless term.start_date <= date and date <= term.end_date
        errors.add(:date, "must in term")
      end
    end
  end
  def events_cannot_overlap
    @dummy_start_time = Time.gm(2000, 1, 1, start_time.hour, start_time.min, start_time.sec)
    @dummy_end_time = Time.gm(2000, 1, 1, end_time.hour, end_time.min, end_time.sec)
    Schedule.where(:date => date).find_each do |event|
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
