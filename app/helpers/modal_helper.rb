module ModalHelper
  def modal_for(name, *args, &block)
    options = args.last.is_a?(Hash) ? args.pop : {}
    if options.has_key?(:css_class)
      klass = options[:css_class] + "-modal"
    else
      klass = "modal"
    end

    content_tag :div, :id => "#{name}-modal", :class => "modal hide fade #{klass}", :tabindex => "-1", :role => "dialog", "aria-labelledby" => "#{name}-label", "aria-hidden" => "true" do
      modal_header = content_tag :div, :class => "modal-header" do
        buf = "".html_safe
        buf.concat(content_tag :button, "\u00D7", :type => "button", :class => "close", "data-dismiss" => "modal", "aria-hidden" => "true")
        title = options[:modal_title]
        buf.concat(content_tag :h3, title, :id => "#{name}-modal-title")
      end

      modal_body = content_tag :div, :class => "modal-body #{klass}-body" do
        content = nil
        content = capture(&block) if block
        content_tag :div, content, :id => "#{name}-modal-body"

      end
      modal_footer = content_tag :div, :class => "modal-footer", :id => "#{name}-modal-footer" do
        buf = "".html_safe
        buf.concat(content_tag :button, "Delete", :class => "btn btn-danger", :id => "#{name}-modal-delete", :style => "float: left") if options[:delete_button]
        buf.concat(content_tag :button, "Close", :class => "btn", "data-dismiss" => "modal", "aria-hidden" => "true")
        buf.concat(content_tag :button, "Save", :class => "btn btn-primary #{klass + "-confirm"}", :id => "#{name}-modal-confirm")
      end
      modal_header.concat(modal_body).concat(modal_footer)
    end
  end
end
