module EventsHelper
  def event_height(start_time, end_time, slot_height, slots_per_hour)
    length = end_time - start_time
    height = length / 3600 * slots_per_hour * slot_height
    if height < slot_height * 2
      slot_height * 2
    else
      height
    end
  end
  def event_top(start_time, slot_height, start_hour, slots_per_hour)
    start_hour = Time.gm(start_time.year, start_time.month, start_time.day, start_hour)
    top = (start_time - start_hour) / 3600 * slots_per_hour * slot_height
    if top > 0 then
      top
    else
      0
    end
  end
  def event_style(start_time, end_time, start_hour, slot_height, slots_per_hour)
    style = ""
    style << "height: #{event_height(start_time, end_time, slot_height, slots_per_hour)}px;"
    style << "top: #{event_top(start_time, slot_height, start_hour, slots_per_hour)}px;"
  end

  def in_current_or_future_terms?(day, current_and_future_terms)
    Term.in_terms?(day, current_and_future_terms)
  end
end
