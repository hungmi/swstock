module ApplicationHelper

  def comment; end

  def active_when(link_path)
    "active" if request.fullpath == link_path
  end

  def render_nav_link(text, link_path)
    content_tag(:li, link_to(text, link_path), :class => active_when(link_path))
  end

end
