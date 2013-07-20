module CalHelper
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

          klass = "wc-cal-event "
          klass << event.calendar_marking.full
          event_buf = 
            content_tag :div, :class => klass, :style => style, :data => {:eventid => event.id} do
              content_buf = "".html_safe
              content_buf.concat(content_tag :div, event.start_time.strftime("%R") + "-" + event.end_time.strftime("%R"), :class => "wc-time ui-corner-all")
              # content_buf.concat(content_tag :div, event.title, :class => "wc-title")
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
      prev_link = link_to nil, {:year => @date.prev_week.year, :month => @date.prev_week.month, :day => @date.prev_week.day}, :id => "cal-nav-prev"
      today_link = link_to nil, {:year => @today.year, :month => @today.month, :day => @today.day}, :id => "cal-nav-today"
      next_link = link_to nil, {:year => @date.next_week.year, :month => @date.next_week.month, :day => @date.next_week.day}, :id => "cal-nav-next"
      current_week = content_tag :span, @date.beginning_of_week(:sunday).strftime("%-d %b %Y") + " - " + @date.end_of_week(:sunday).strftime("%-d %b %Y"), :id => "cal-nav-title"
      nav = prev_link.concat(today_link).concat(next_link).concat(current_week)
      content_tag :div, nav, :id => "cal-nav", :style => "display: none"
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
      @months = [*(first_month..12)].concat([*(1...first_month)])
    end

    def draw_annual_calendar_body
      
      content_tag :table, draw_annual_calendar_title.concat(draw_month_calendars), :class => "ac-table unselectable"
    end
    
    def draw_annual_calendar_title
      prev_link = link_to nil, {:year => @year - 1}, :id => "cal-nav-prev"
      next_link = link_to nil, {:year => @year + 1}, :id => "cal-nav-next"
      today_link = link_to nil, {:year => Date.today.year}, :id => "cal-nav-today"
      title = content_tag :span, @year, :id => "cal-nav-title" 
      content = prev_link.concat(today_link).concat(next_link).concat(title)
      content_tag :div, content, :id => "cal-nav", :style => "display: none"
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
          monthly_calendar_content = content_tag :div, (builder.draw_calendar :show_links => false, :show_year => false), :class => "ac-mc-container"
          grid_content.concat(monthly_calendar_content)
          row_content.concat(content_tag :td, grid_content, :class => "ac-table-grid")
        end
        buf.concat(content_tag :tr, row_content)
      end
      content_tag :tbody, buf
    end
  end

  class MonthlyCalendarBuilder < CalendarBuilder
    def initialize(parent, objects, options)
      super(parent, objects, options)
      @today = options[:today] || Date.today
      @year = options[:year] || @today.year
      @month = options[:month] || @today.month
      @date = Date.new(@year, @month)
    end


    def draw_calendar(*args)
      options = args.last.is_a?(Hash) ? args.pop : {}
      day_method = options.delete(:day_method) || :date
      marking_method = options.delete(:marking_method) || :calendar_marking
      day_of_week = options[:day_of_week] || ["Su", "M", "Tu", "W", "Th", "F", "Sa"]
      month_names = options[:month_names] || Date::MONTHNAMES
      show_links = options.has_key?(:show_links) ? options[:show_links] : true
      show_year = options.has_key?(:show_year) ? options[:show_year] : true
      week_padding = options.has_key?(:week_padding) ? options[:week_padding] : true

      nav = content_tag :tr, :class => "nav" do
        prev_link = content_tag :th, (show_links ? (link_to (content_tag :i, nil, :class => "icon-arrow-left"), :month => @date.last_month.month, :year => @date.last_month.year) : ""), :colspan => 1
        next_link = content_tag :th, (show_links ? (link_to (content_tag :i, nil, :class => "icon-arrow-right"), :month => @date.next_month.month, :year => @date.next_month.year) : ""), :colspan => 1
        title = content_tag :th, (show_year ? @date.strftime("%b %Y") : @date.strftime("%b")), :colspan => 5, :class => "month-title"

        prev_link.concat(title).concat(next_link)
      end
      wdays = content_tag :tr do
        buf = "".html_safe
        day_of_week.each do |c|
          buf.concat(content_tag :td, c, :class => "weekday")
        end
        buf
      end
      cal_days = "".html_safe
      week = 0
      for day in @date.beginning_of_month.beginning_of_week(:sunday) .. @date.end_of_month.end_of_week(:sunday)
        klass = "day-text "
        klass << "today " if day == @today
        klass << "not-current-month" if day.month != @month
        if @objects.has_key? day
          klass << day_marking(@objects[day], marking_method)
        end
        if day.sunday?
          cal_days.concat(tag :tr, nil, true)
          week += 1
        end

        text = content_tag :span, day.day
        cal_days.concat(klass.empty? ? (content_tag :td, text, :data => {:year => day.year, :month => day.month, :day => day.day}) : (content_tag :td, text, :class => klass, :data => {:year => day.year, :month => day.month, :day => day.day}))
        cal_days.concat("</tr>".html_safe) if day.saturday?
      end
      if week_padding and week < 6
        empty_week = content_tag :tr, :class => "empty-week" do
          content_tag :td, "weekpadding", :colspan => 7
        end
        cal_days.concat(empty_week)
      end

      content_tag :table, nav.concat(wdays).concat(cal_days), :class => "mc-table"
            
    end
private
    def day_marking(objs, marking_method)
      marking = ""
      for obj in objs
        m = obj.send(marking_method).full
        if marking.empty?
          marking = m
        else
          marking = "mix" if m != marking
        end
      end
      marking
    end
  end
end
