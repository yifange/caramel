module ApplicationHelper
  def my_tag(&block)
    content = capture(Time.now, &block)
    content_tag :p, content
  end
end
