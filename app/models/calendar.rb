class Calendar < ActiveRecord::Base
  attr_accessor :recurring
  belongs_to :school
  belongs_to :term
  validate :start_time_cannot_after_end_time, :start_time_and_end_time_must_in_school_hour, :events_cannot_overlap

  def save_recurring
    save
  end

  def all_similar_events
    @similar_events || (@similar_events = Calendar.where(:term_id => term_id, :school_id => school_id, :day_of_week => day_of_week))
  end

  def start_time_cannot_after_end_time
    if start_time >= end_time
      errors.add(:end_time, "must after start time.")
    end
  end
  def start_time_and_end_time_must_in_school_hour
    start_hour = Time.gm(start_time.year, start_time.month, start_time.day, 8)
    end_hour = Time.gm(end_time.year, end_time.month, end_time.day, 16)
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
    events = Calendar.where(:date => date)
    for event in events
      if overlap?(event)
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
end
