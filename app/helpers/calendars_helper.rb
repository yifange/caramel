module CalendarsHelper
  def day_marking(objs)
    marking = ""
    for obj in objs
      m = obj.available if obj.respond_to? :available
      if marking.empty?
        marking = m ? "available" : "unavailable"
      else
        marking = "mix" if m != marking
      end
    end
    marking
  end
end
