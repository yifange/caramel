module CalendarHelper
  def monthly_calendar_for(objects, *args, &block)
    options = args.last.is_a?(Hash) ? args.pop : {}
    content = capture(MonthlyCalendarBuilder.new(self, objects || [], options), &block)
    content_tag :div, content, :class => "mc-container"

  end
  def annual_calendar_for(objects, *args, &block)
    options = args.last.is_a?(Hash) ? args.pop : {}
    content = capture(AnnualCalendarBuilder.new(self, objects || [], options), &block)
    content_tag :div, content, :class => "ac-container"
  end

  def weekly_calendar_for(objects, *args, &block)
    options = args.last.is_a?(Hash) ? args.pop : {}
    content = capture(WeeklyCalendarBuilder.new(self, objects || [], options), &block)
    content_tag :div, content, :class => "wc-container"
  end
  
  class CalendarBuilder
    attr_accessor :parent
    delegate :capture, :content_tag, :tag, :link_to, :concat, :to => :parent
    def initialize(parent, objects, options)
      @parent, @objects, @options = parent, objects, options
    end
  end

  class WeeklyCalendarBuilder < CalendarBuilder
    def initialize(parent, objects, options)
      super(parent, objects, options)
      
      year = options[:year] || Date.today.year
      month = options[:month] || Date.today.month
      day = options[:day] || Date.today.day
      @start_hour = options[:start_hour] || 8
      @end_hour = options[:end_hour] || 16
      @slots_per_hour = options[:slots_per_hour] || 3
      @slot_height = 18
      @date = Date.new(year, month, day)
      @today = Date.today
    end

    def draw_events(day)
      if @objects.has_key? day
        events = @objects[day]
        buf = "".html_safe
        for event in events
          style = ""
          style << "height: #{event_height(event[:start_time], event[:end_time])}px;"
          style << "top: #{event_top(event[:start_time])}px;"

          event_buf = 
            content_tag :div, :class => "wc-cal-event", :style => style, :data => {:eventid => event.id} do
              content_buf = "".html_safe
              content_buf.concat(content_tag :div, event.start_time.strftime("%R") + "-" + event.end_time.strftime("%R"), :class => "wc-time ui-corner-all")
              content_buf.concat(content_tag :div, event.title, :class => "wc-title")
              content_buf
            end
          buf.concat(event_buf)
        end
        buf
      end
    end
    
    def event_height(start_time, end_time)
      length = end_time - start_time
      height = length / 3600 * @slots_per_hour * @slot_height
      if height < @slot_height * 0.7
        @slot_height
      else
        height
      end
    end
    def event_top(start_time)
      start_hour = Time.gm(start_time.year, start_time.month, start_time.day, @start_hour)
      puts "start_time ", start_time, " start_hour ", start_hour
      top = (start_time - start_hour) / 3600 * @slots_per_hour * @slot_height
      if top > 0 then
        top
      else
        0
      end
    end
    def draw_weekly_calendar_nav
      prev_link = link_to "<", {:year => @date.prev_week.year, :month => @date.prev_week.month, :day => @date.prev_week.day}, :class => "btn"
      today_link = link_to "today", {:year => @today.year, :month => @today.month, :day => @today.day}, :class => "btn"
      next_link = link_to ">", {:year => @date.next_week.year, :month => @date.next_week.month, :day => @date.next_week.day}, :class => "btn"
      nav = prev_link.concat(today_link).concat(next_link)
      content_tag :div, nav, :class => "wc-nav"
    end
    
    def draw_weekly_calendar_body(*args)
      options = args.last.is_a?(Hash) ? args.pop : {}

      day_of_week = options[:day_of_week] || Date::DAYNAMES

      wc_header = content_tag :table, :class => "wc-header" do
        content_tag :tbody do
          content_tag :tr do
            buf = "".html_safe
            buf.concat(content_tag :td, nil, :class => "wc-time-column-header")
            for day in @date.beginning_of_week(:sunday)..@date.end_of_week(:sunday)
              klass = "wc-day-column-header wc-day-#{day.strftime("%w")}"
              if day == @today
                klass << " wc-today"
              end
              buf.concat(content_tag :td, (link_to day.strftime("%a %-m-%d"), "#", :class => "wc-day-column-header"), :class => klass)
            end
            # buf.concat(content_tag :td, nil, :class => "wc-scrollbar-shim")
            buf
          end
        end
      end

      grid = content_tag :div, :class => "wc-scrollable-grid" do
        content_tag :table, :class => "wc-time-slots" do
          content_tag :tbody do
            timeslot = content_tag :tr do
              buf = "".html_safe
              buf.concat(tag :td, :class => "wc-grid-timeslot-header")
              timeslot_wrapper = content_tag :div, :class => "wc-time-slot-wrapper" do
                  content_tag :div, :class => "wc-time-slots" do
                    slots_html = "".html_safe
                    for hour in @start_hour..@end_hour
                      for slot in 1...@slots_per_hour
                        slots_html.concat(content_tag :div, nil, {:class => "wc-time-slot wc-hour-#{hour} wc-hour-slot-#{slot}"})
                      end
                      slots_html.concat(content_tag :div, nil, {:class => "wc-time-slot wc-hour-end wc-hour-#{hour} wc-hour-slot-#{@slots_per_hour}"})
                    end
                    slots_html
                  end
              end
              buf.concat(content_tag :td, timeslot_wrapper, :colspan => 7)
            end
            day_columns = content_tag :tr do
              timeslot_header = content_tag :td, :class => "wc-grid-timeslot-header" do
                buf = "".html_safe
                for hour in @start_hour..@end_hour
                  buf.concat(content_tag :div, (content_tag :div, "#{hour}:00", :class => "wc-time-header-cell"), :class => "wc-hour-header")
                end
                buf
              end

              columns = "".html_safe
              for day in @date.beginning_of_week(:sunday)..@date.end_of_week(:sunday)
                klass = "wc-day-column day-#{day.strftime("%w")}"
                if day == @today
                  klass << " wc-today"
                end
                column = content_tag :td, :class => klass do
                  content_tag :div, :class => "wc-day-column-inner" ,:data => {:date => day.strftime} do
                    draw_events(day) 
                  end
                end
                columns.concat(column)
              end

              timeslot_header.concat(columns)
            end  
            timeslot.concat(day_columns)
          end
        end 

      end
      wc_header.concat(grid)
    end
    # def draw_weekly_calendar(&block)
    #   content = capture(&block)
    # end
  end


  class AnnualCalendarBuilder < CalendarBuilder
    def initialize(parent, objects, options)
      super(parent, objects, options)
      first_month = options[:first_month] || 9
      @year = options[:year] || Date.today.year
      # XXX restrict the start month
      @months = [*(first_month..12)].concat([*(1...first_month)])
    end

    def draw_annual_calendar_body
      content = capture do
        concat draw_month_calendars 
      end
      content_tag :table, content
    end
    
    def draw_annual_calendar_title(*args)
      options = args.last.is_a?(Hash) ? args.pop : {}
      show_prev_next_links = options.has_key?(:show_prev_next_links) ? options[:show_prev_next_links] : true
      prev_link = if show_prev_next_links then link_to "<", :year => @year - 1 else "".html_safe end
      next_link = if show_prev_next_links then link_to ">", :year => @year + 1 else "".html_safe end
      title = content_tag :span, @year, :class => "calendar-year-name"
      content = prev_link.concat(title).concat(next_link)
      
      content_tag :div, content, :class => "calendar-year-nav", :class => "calendar-year-nav"
    end

    def draw_month_calendars(*args)
      #XXX restrict the column numbers
      options = args.last.is_a?(Hash) ? args.pop : {}
      columns = options[:columns] || 4
      rows = 12 / columns
      buf = "".html_safe
      for row_ind in 0...rows
        row_content = "".html_safe
        for column_ind in 0...columns
          month = @months[row_ind  * columns + column_ind]
          builder = MonthlyCalendarBuilder.new(@parent, @objects, :month => month, :year => @year)
          grid_content = "".html_safe
          # XXX option not working
          grid_content.concat(builder.draw_month_title(:show_prev_next_links => false))
          monthly_calendar_content = builder.draw_calendar :marking_method => :mark do |d, obj|
            concat d.day
          end
          grid_content.concat(monthly_calendar_content)
          row_content.concat(content_tag :td, grid_content)
        end
        buf.concat(content_tag :tr, row_content)
      end
      content_tag :tbody, buf
    end
  end

  class MonthlyCalendarBuilder < CalendarBuilder
    def initialize(parent, objects, options)
      super(parent, objects, options)
      @calendar = Calendar.new(options)
      @today = options[:today] || Time.now
    end

    def draw_month_title(*args)
      options = args.last.is_a?(Hash) ? args.pop : {}
      month_names = options[:month_names] || Date::MONTHNAMES
      
      show_prev_next_links = options.has_key?(:show_prev_next_links) ? options[:show_prev_next_links] : true
      prev_link = if show_prev_next_links then link_to "<", :month => @calendar.date.last_month.month, :year => @calendar.date.last_month.year else "".html_safe end
      next_link = if show_prev_next_links then link_to ">", :month => @calendar.date.next_month.month, :year => @calendar.date.next_month.year else "".html_safe end
      
      content_tag :div, prev_link.concat(content_tag :span, month_names[@calendar.month], :class => "calendar-month-name").concat(next_link), :class => "calendar-month-nav"
    end

    def draw_calendar(*args, &block)
      options = args.last.is_a?(Hash) ? args.pop : {}
      day_method = options.delete(:day_method) || :date
      marking_method = options.delete(:marking_method) || :calendar_marking
      day_of_week = options[:day_of_week] || ["Su", "M", "Tu", "W", "Th", "F", "Sa"]
      thead = content_tag :thead do
        content_tag :tr do
          buf = "".html_safe
          day_of_week.each do |c|
            buf.concat(content_tag :th, c.html_safe)
          end
          buf
        end
      end
      tbody = content_tag :tbody do
        buf = ""
        @calendar.objects_for_days(@objects, day_method, marking_method).to_a.sort{ |a1, a2| a1.first <=> a2.first }.each do |o|
          key, array = o
          day, objects, marking = array
          buf.concat(tag(:tr, options, true)) if (day.wday == @calendar.first_weekday)
          block_content = capture(day, objects, &block) if block_given?
          buf.concat(content_tag :td, block_content, :class => td_classes(day, marking))
          buf.concat('</tr>') if (day.wday == @calendar.last_weekday)
        end
        buf.html_safe
      end
      content_tag :table, thead.concat(tbody)
            
    end

private

    def objects_for_days
      @calendar.objects_for_days(@objects)
    end

    def td_classes(day, marking)
      classes = []
      classes << 'today'    if day.strftime("%Y-%m-%d") ==  @today.strftime("%Y-%m-%d")
      classes << 'notmonth' if day.month != @calendar.month
      classes << 'weekend'  if day.wday == 0 or day.wday == 6
      classes << 'future'   if day > @today.to_date
      classes << "calendar-marking-" + marking.downcase    if marking
      if classes.empty? then "" else classes.join(" ") end
    end
  end

  class Calendar
    attr_accessor :first_weekday, :last_weekday, :month, :year, :date

    # :first lets you set the first day to start the calendar on (default is the first day of the given :month and :year).
    #   :first => :today will use Date.today
    # :last lets you set the last day of the calendar (default is the last day of the given :month and :year).
    #   :last => :thirty will show 30 days from :first
    #   :last => :week will show one week
    def initialize(options={})
      @year               = options[:year] || Time.now.year
      @month              = options[:month] || Time.now.month
      @date               = Date.new(@year, @month)
      @first_day_of_week  = options[:first_day_of_week] || 0
      @first_weekday      = first_day_of_week(@first_day_of_week)
      @last_weekday       = last_day_of_week(@first_day_of_week)

      @first = options[:first]==:today ? Date.today : options[:first] || Date.civil(@year, @month, 1)

      if options[:last] == :thirty_days || options[:last] == :thirty
        @last = @first + 30
      elsif options[:last] == :one_week || options[:last] == :week
        @last = @first
      else
        @last = options[:last] || Date.civil(@year, @month, -1)
      end

    end

    def each_day
      first_day.upto(last_day) do |day|
        yield(day)
      end
    end

    def last_day
      last = @last
      while(last.wday % 7 != @last_weekday % 7)
        last = last.next
      end
      last
    end

    def first_day
      first = @first - 6
      while(first.wday % 7 != (@first_weekday) % 7)
        first = first.next
      end
      first
    end

    def objects_for_days(objects, day_method, marking_method)
      unless @objects_for_days
        @objects_for_days = {}
        days.each{|day| @objects_for_days[day.strftime("%Y-%m-%d")] = [day, []]}
        objects.each do |o|
          date = o.send(day_method.to_sym).strftime("%Y-%m-%d")
          marking = o.send(marking_method.to_sym)
          if @objects_for_days[date]
            @objects_for_days[date][1] << o
            if @objects_for_days[date][2] && @objects_for_days[date][2] != marking
              @objects_for_days[date][2] = "mix"
            else
              @objects_for_days[date][2] = marking
            end
          end
        end
      end
      @objects_for_days
    end

    def days
      unless @days
        @days = []
        each_day{|day| @days << day}
      end
      @days
    end

    def mjdays
      unless @mjdays
        @mdays = []
        each_day{|day| @days << day}
      end
      @days
    end

    def first_day_of_week(day)
      day
    end

    def last_day_of_week(day)
      if day > 0
        day - 1
      else
        6
      end
    end
  end

end
