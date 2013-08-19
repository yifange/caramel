module MultipleSelectionHelper

  def multiple_selection(options, init_selected_options, pk, url)
    buf = "".html_safe
    options_buf = "".html_safe
    options.each do |option|
      selected = false
      init_selected_options.each do |init_selected_option|
        if init_selected_option[:id] == option[:id]
          selected = true
          break
        end
      end
      options_buf += content_tag("option", option[:text], value: option[:id], selected: ("selected" if selected))
    end
    buf.concat(content_tag("select", options_buf, multiple: true, class: "select2-multiple", 'data-pk' => pk, 'data-value' => url))
  end

end
