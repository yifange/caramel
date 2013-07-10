module CalendarHelper
  def monthly_calendar_for(objects, *args, &block)
    options = args.last.is_a?(Hash) ? args.pop : {}
    content = capture(MonthlyCalendarBuilder.new(self, objects || [], options), &block)
    content_tag :div, content, :class => "monthly-calendar"

  end
  def annual_calendar_for(objects, *args, &block)
    options = args.last.is_a?(Hash) ? args.pop : {}
    content = capture(AnnualCalendarBuilder.new(self, objects || [], options), &block)
    content_tag :div, content, :class => "annual-calendar"
  end
  
  class CalendarBuilder
    attr_accessor :parent
    delegate :capture, :content_tag, :tag, :link_to, :concat, :to => :parent
    def initialize(parent, objects, options)
      @parent = parent
      @objects, @options = objects, options
    end
  end

  class AnnualCalendarBuilder < CalendarBuilder
    def initialize(parent, objects, options)
      super(parent, objects, options)
      first_month = options[:first_month] || 9
      @year = options[:year] || Date.today.year
      # XXX restrict the start month
      @months = [*(first_month..12)].concat([*(1...first_month)])
    end

    def draw_annual_calendar(&block)
      # options = args.last.is_a?(Hash) ? args.pop : {}
      content = capture(&block)
      content_tag :table, content
    end
    
    def draw_annual_calendar_title(*args)
      options = args.last.is_a?(Hash) ? args.pop : {}
      show_prev_next_links = options.delete(:show_prev_next_links) || true
      prev_link = if show_prev_next_links then link_to "<", :year => @year - 1 else "" end
      next_link = if show_prev_next_links then link_to ">", :year => @year + 1 else "" end
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
      month_names = options.delete(:month_names) || Date::MONTHNAMES
      show_prev_next_links = options.delete(:show_prev_next_links) || false
      prev_link = if show_prev_next_links then link_to "<", :month => @calendar.date.last_month.month, :year => @calendar.date.last_month.year else "".html_safe end
      next_link = if show_prev_next_links then link_to ">", :month => @calendar.date.next_month.month, :year => @calendar.date.next_month.year else "".html_safe end
      
      content_tag :div, prev_link.concat(content_tag :span, month_names[@calendar.month], :class => "calendar-month-name").concat(next_link), :class => "calendar-month-nav"
    end

    def draw_calendar(*args, &block)
      options = args.last.is_a?(Hash) ? args.pop : {}
      day_method = options.delete(:day_method) || :date
      marking_method = options.delete(:marking_method) || :calendar_marking
      day_of_week = options.delete(:day_of_week) || ["M", "Tu", "W", "Th", "F", "Sa", "Su"]
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
            @objects_for_days[date][2] = marking
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
