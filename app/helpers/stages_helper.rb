module StagesHelper
  def render_input_or_text(f, obj, attribute)
    return content_tag(:td, obj.public_send(attribute)) if obj.public_send(attribute).present?
    f.input attribute.to_sym#, placeholder: :translate
  end
  def render_link_or_text(link_text, link, obj, attribute)
    return content_tag(:td, obj.public_send(attribute)) if obj.public_send(attribute)
    content_tag :td do
      button_to link_text, link, method: :patch
    end
  end
  def render_stage_color(stage)
    return 'finished' if stage.finished?
    return 'danger' if stage.danger?
    #return 'processing' if stage.running?
  end
end
