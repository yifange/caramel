module NavFilterHelper
  def nav_filter_for(name, objs, *args, &block)
    return unless objs
    options = args.last.is_a?(Hash) ? args.pop : {}
    content_tag :li, :class => "dropdown pull-right" do
      name_content = content_tag :a, (content_tag :span, name, :id => "subnav-#{name}-name").concat(content_tag :b, nil, :class => "caret"), :class => "dropdown-toggle", "data-toggle" => "dropdown", :href => "#"
      menu_content = content_tag :ul, :role => "menu", "aria-labelledby" => "dlabel", :class => "dropdown-menu" do
        if name == "school"
          school_menu(objs, options, &block)
        elsif name == "program"
          program_menu(objs, options, &block)
        end
      end
      name_content.concat(menu_content)
    end
  end

  def school_menu(objs, options, &block)
    base_url = options[:base_url]
    year = options[:year]
    month = options[:month]
    day = options[:day]
    buf = "".html_safe
    objs.each do |obj|
      url = base_url + "?school_id=#{obj.id}" if obj.is_a? School
      url = base_url + "?program_id=#{obj.id}" if obj.is_a? Program
      url += "&year=#{year}" if year
      url += "&month=#{month}" if month
      url += "&day=#{day}" if day
      item = content_tag :li do
        link_to url, "tabindex" => "-1", :data => {:school => obj.id} do
          obj.full
        end
      end
      buf.concat(item)
    end
    buf
  end
  def program_menu(objs, options, &block)
    base_url = options[:base_url]
    year = options[:year]
    month = options[:month]
    day = options[:day]
    buf = "".html_safe
    objs.group("school_id").each do |obj|
      school = obj.school
      programs = objs.where(:school_id => obj[:school_id])
      menu = content_tag :li, :class => "dropdown-submenu" do
        item = concat(link_to school.full, "#", :tabindex => "-1")
        submenu = content_tag :ul, :class => "dropdown-menu" do
          subitems = "".html_safe
          programs.each do |program|
            url = base_url + "?program_id=#{program.id}"
            url += "&year=#{year}" if year
            url += "&month=#{month}" if month
            url += "&day=#{day}" if day
            subitem = content_tag :li do
              link_to url, "tabindex" => "-1", :data => {:program => program.id} do
                program.program_type.name + ", " + program.instrument.name
              end
            end
            subitems.concat(subitem)
          end
          subitems
        end
        item.concat(submenu)
      end
      buf.concat(menu)
    end
    buf
  end
end
