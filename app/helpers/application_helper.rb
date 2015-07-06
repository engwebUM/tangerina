module ApplicationHelper
  def  user_reviser
    content_tag(:li, link_to('Reviews', reviews_path)) if current_user?
  end

  def current_user?
    current_user.revisers.present? || current_user.admin?
  end
end
