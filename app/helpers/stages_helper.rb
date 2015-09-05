module StagesHelper
  def render_input_or_text(f, obj, attribute)
    return content_tag(:td, obj.public_send(attribute)) if obj.public_send(attribute).present?
    f.input attribute.to_sym
  end
  def render_link_or_text(link_text, link, obj, attribute)
    return content_tag(:td, obj.public_send(attribute)) if obj.public_send(attribute)
    content_tag :td do
      button_to link_text, link, method: :patch
    end
  end
end
