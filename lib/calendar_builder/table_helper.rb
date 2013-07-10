module TableHelper
  def table(&block)
    content = capture(&block)
    content_tag :table, content
  end

  def thead(*args)
    content_tag :thead do
      content_tag :tr do
        args.each do |c|
          content_tag :th, c.html_safe
        end
      end
    end
  end
  def tbody(&block)
    content = capture(&block)
    content_tag :tbody, content
  end
end
