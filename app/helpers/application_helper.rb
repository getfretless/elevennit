module ApplicationHelper
  def flash_class(name)
    alert_type = case name.to_s
      when 'notice' then 'alert-success'
      when 'error'  then 'alert-danger'
      when 'alert'  then 'alert-danger'
      when 'info'   then 'alert-info'
      when 'warning' then 'alert-warning'
      else "alert-#{name}"
    end
    alert_type
  end

  def post_link_url(post)
    return post.link if post.link?
    return post_url(post) if post.text?
  end

  def post_title_hostname(post)
    content_tag :small do
      "(#{ link_to URI.parse(post_link_url post).hostname, post_link_url(post)})".html_safe
    end
  end

  def post_title_link(post)
    content_tag :div, class: 'title' do
      link_to(post.title, post_link_url(post)) +
      ' ' + post_title_hostname(post)
    end
  end

  def sidebar(sidebar_content)
    content_for(:sidebar) do
      sidebar_content
    end
  end

  def comment_link_text(number_of_comments)
    "#{number_of_comments} #{'comment'.pluralize(number_of_comments)}"
  end
end
