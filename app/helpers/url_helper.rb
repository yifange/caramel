module UrlHelper
  def active_link_fullpath(link_text, link_path)
    class_name = request.fullpath == link_path ? 'active' : ''
    content_tag(:li, :class => class_name) do
      link_to link_text, link_path
    end
  end

  def active_link_partialpath(link_text, link_path)
    class_name = request.fullpath.sub(/[^\/]*$/, '') == link_path.sub(/[^\/]*$/, '') ? 'active' : ''
    content_tag(:li, :class => class_name) do
      link_to link_text, link_path
    end
  end
end
