module FlashHelper

  # def flash_message(type, text)
  #   flash[type] ||= []
  #   flash[type] << text
  # end

  def render_flash
    buf = "".html_safe
    flash.each do |type, messages|
      messages.each do |m|
        buf += content_tag(:div, content_tag(:button, '×', type: "button", class: 'close', "data-dismiss" => "alert") + content_tag(:div, m), class: "#{flash_class(type)}")
      end
    end
    content_tag(:div, buf, class: "flash-message")
  end

end
