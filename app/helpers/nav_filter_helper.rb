module NavFilterHelper
  def nav_filter_for(name, objs, *args, &block)
    options = args.last.is_a?(Hash) ? args.pop : {}
    base_url = options[:base_url]
    year = options[:year]
    month = options[:month]
    day = options[:day]
    

    content_tag :li, :class => "dropdown pull-right" do
      name_content = content_tag :a, (content_tag :span, name, :id => "subnav-#{name}-name").concat(content_tag :b, nil, :class => "caret"), :class => "dropdown-toggle", "data-toggle" => "dropdown", :href => "#"
      menu_content = content_tag :ul, :role => "menu", "aria-labelledby" => "dlabel", :class => "dropdown-menu" do
        buf = "".html_safe
        objs.each do |obj|
          url = base_url + "?school_id=#{obj.id}" if obj.is_a? School
          url = base_url + "?program_id=#{obj.id}" if obj.is_a? Program
          url += "&year=#{year}" if year
          url += "&month=#{month}" if month
          url += "&day=#{day}" if day
          item = content_tag :li do
            link_to url, "tab-index" => "-1", :data => {:school => obj.id} do
              block.call(obj)
            end
          end
          buf.concat(item)
        end
        buf
      end
      name_content.concat(menu_content)
    end
  end
end
