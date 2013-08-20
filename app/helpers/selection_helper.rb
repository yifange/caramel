module SelectionHelper

  def singular_selection(options, init_selected_option_id, pk, url, name)
    buf = "".html_safe
    options_buf = "".html_safe
    options.each do |option|
      selected = false
      if init_selected_option_id == option[:id]
        selected = true
      end
      options_buf += content_tag("option", option[:text], value: option[:id], selected: ("selected" if selected))
    end
    buf.concat(content_tag("select", options_buf, class: "select2", 'data-pk' => pk, 'data-value' => url, 'data-name' => name))
  end

  def multiple_selection(options, init_selected_option_ids, pk, url, name)
    buf = "".html_safe
    options_buf = "".html_safe
    options.each do |option|
      selected = false
      init_selected_option_ids.each do |init_selected_option_id|
        if init_selected_option_id == option[:id]
          selected = true
          break
        end
      end
      options_buf += content_tag("option", option[:text], value: option[:id], selected: ("selected" if selected))
    end
    buf.concat(content_tag("select", options_buf, multiple: true, class: "select2", 'data-pk' => pk, 'data-value' => url, 'data-name' => name))
  end

end
