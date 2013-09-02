module UrlHelper

  def active_link_fullpath(link_text, link_path)
    class_name = request.fullpath == link_path ? 'active' : ''
    content_tag(:li, :class => class_name) do
      link_to link_text, link_path
    end
  end

  def active_link_partialpath(link_text, link_path, active_links)
    class_name = ''
    active_links.each do |active_link|
      if active_link == request.fullpath 
        class_name = 'active'
        break
      end
    end
    content_tag(:li, :class => class_name) do
      link_to link_text, link_path
    end
  end

  def controller?(*controller)
    controller.include?(params[:controller])
  end
  def action?(*action)
    action.include?(params[:action])
  end
  def active_class(controller, *action)
    if controller?(controller) and action?(*action)
      "active"
    else
      ""
    end
  end
end
