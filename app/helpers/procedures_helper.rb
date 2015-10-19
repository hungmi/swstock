module ProceduresHelper
  def render_input_or_text(f, obj, attribute)
    return content_tag(:td, obj.public_send(attribute)) if obj.public_send(attribute)
    f.input attribute.to_sym, input_html: { class: 'attribute' }
  end
end
