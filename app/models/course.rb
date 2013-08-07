class Course < ActiveRecord::Base
  belongs_to :program
  validate :events_cannot_overlap
  def start_date
    program.start_date
  end
  def end_date
    program.end_date
  end
  # def recurring?
  #   type == "GroupCourse"
  # end
  def group
    type == "GroupCourse"
  end

  
  private
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
  def overlap?(event)
    if date == event.date and @dummy_end_time > event.start_time and @dummy_start_time < event.end_time
      true
    else
      false
    end
  end
end
