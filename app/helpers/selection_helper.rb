module SelectionHelper

  def singular_selection(class_name, options, init_selected_option_id, locked, pk, url, name)
    buf = "".html_safe
    options_buf = "".html_safe
    options.each do |option|
      selected = false
      if init_selected_option_id == option[:id]
        selected = true
      end
      options_buf += content_tag("option", option[:text], value: option[:id], selected: ("selected" if selected))
    end
    buf.concat(content_tag("select", options_buf, class: class_name, 'data-pk' => pk, 'data-value' => url, 'data-name' => name, 'disabled' => ("true" if locked)))
  end

  def multiple_selection(class_name, options, init_selected_option_ids, init_locked_option_ids, pk, url, name)
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
      locked = false
      init_locked_option_ids.each do |init_locked_option_id|
        if init_locked_option_id == option[:id]
          locked = true
          break
        end
      end
      options_buf += content_tag("option", option[:text], value: option[:id], selected: ("selected" if selected), 'data-locked' => ("true" if locked))
    end
    buf.concat(content_tag("select", options_buf, multiple: true, class: class_name, 'data-pk' => pk, 'data-value' => url, 'data-name' => name))
  end

end
