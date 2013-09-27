class Calendar < ActiveRecord::Base
  attr_accessor :recurring
  belongs_to :calendar_marking
  belongs_to :school
  belongs_to :term
  validate :start_time_cannot_after_end_time, :start_time_and_end_time_must_in_school_hour, :events_cannot_overlap
  before_save :set_day_of_week
  
  def save_recurring
    day_of_week = date.wday
    days = Term.find(term_id).recurring_days(day_of_week, :start_date => date)
    r = true
    days.each do |day|
      r = r && Calendar.new(:date => day, :start_time => start_time, :end_time => end_time, :school_id => school_id, :available => available, :day_of_week => day_of_week).save
      # FIXME keep this for future term support 
      # r = r && Calendar.new(:date => day, :term_id => term_id, :start_time => start_time, :end_time => end_time, :school_id => school_id, :available => available, :day_of_week => day_of_week).save
    end
    # XXX report error. Use flash???
    # unless r end
  end
  def update_recurring(calendar_params)
    all_similar_events.each do |e|
      e.update_attributes(calendar_params)
    end
  end
  def destroy_recurring
    all_similar_events.each do |e|
      e.destroy
    end
  end
  def all_similar_events
    @similar_events || (@similar_events = Calendar.where(:term_id => term_id, :school_id => school_id, :day_of_week => day_of_week))
  end
  def date_must_in_term
    errors.add(:date, "must in term") unless Term.find(term_id).in_term?(date)
  end

  def start_time_cannot_after_end_time
    if start_time >= end_time
      errors.add(:end_time, "must after start time.")
    end
  end
  def start_time_and_end_time_must_in_school_hour
    start_hour = Time.gm(start_time.year, start_time.month, start_time.day, 6)
    end_hour = Time.gm(end_time.year, end_time.month, end_time.day, 18)
    if start_time < start_hour or start_time > end_hour
      errors.add(:start_time, "must be in school hour")
    end
    if end_time < start_hour or end_time > end_hour
      errors.add(:end_time, "must be in school hour")
    end
  end

  def events_cannot_overlap
    @dummy_start_time = Time.gm(2000, 1, 1, start_time.hour, start_time.min, start_time.sec)
    @dummy_end_time = Time.gm(2000, 1, 1, end_time.hour, end_time.min, end_time.sec)
    Calendar.where(:date => date, :school_id => school_id).find_each do |event|
      if event.id != id and overlap?(event)
        errors.add(:base, "events overlap")
        return
      end
    end
  end
  
  private
  def overlap?(event)
    if date == event.date and @dummy_end_time > event.start_time and @dummy_start_time < event.end_time
      true
    else
      false
    end
  end
  def set_day_of_week
    self.day_of_week = date.wday
  end
end
