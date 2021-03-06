module NavFilterHelper
  def nav_filter_for(name, objs, *args)
    return unless objs
    options = args.last.is_a?(Hash) ? args.pop : {}
    content_tag :li, :class => "dropdown pull-right" do
      name_content = content_tag :a, (content_tag :span, options[:default_text], :id => "subnav-#{name}-name").concat(content_tag :b, nil, :class => "caret"), :class => "dropdown-toggle", "data-toggle" => "dropdown", :href => "#"
      menu_content = content_tag :ul, :role => "menu", "aria-labelledby" => "dlabel", :class => "dropdown-menu" do
        if name == "school"
          school_menu(objs, options)
        elsif name == "program"
          program_menu(objs, options)
        end
      end
      name_content.concat(menu_content)
    end
  end

  def school_menu(objs, options)
    base_url = options[:base_url]
    year = options[:year]
    month = options[:month]
    day = options[:day]
    buf = "".html_safe
    objs.each do |obj|
      url = base_url + "?school_id=#{obj.id}"
      url += "&year=#{year}" if year
      url += "&month=#{month}" if month
      url += "&day=#{day}" if day
      item = content_tag :li do
        link_to url, "tabindex" => "-1", :data => {:school => obj.id} do
          obj.name
        end
      end
      buf.concat(item)
    end
    buf
  end
  def program_menu(objs, options)
    base_url = options[:base_url]
    year = options[:year]
    month = options[:month]
    day = options[:day]
    buf = "".html_safe 
    program_hash = {}
    objs.order("instrument_id").each do |obj|
      program_hash[obj.school] = [] unless program_hash.has_key? obj.school
      program_hash[obj.school] << obj
    end
    
    program_hash.each do |school, programs|
      menu = content_tag :li, :class => "dropdown-submenu" do
        item = link_to school.name, '#', :tabindex => '-1'
        submenu = content_tag :ul, :class => 'dropdown-menu' do
          subitems = ''.html_safe
          programs.each do |program|
            url = "#{base_url}?program_id=#{program.id}"
            url += "&year=#{year}" if year
            url += "&month=#{month}" if month
            url += "&day=#{day}" if day
            subitem = content_tag :li do
              link_to url, 'tabindex' => '-1', :data => {:program => program.id} do
                program.program_type.name + " - " + program.instrument.name
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
