module ApplicationHelper

  def error_notices(error_resource)
    error_resource.errors.each do |error|
      "<li>#{error}</li>"
    end
  end

  def current_user_is_authorized_to_delete(resource)
    logged_in? && current_user.id == resource.user_id
  end

  def current_user? (user)
    logged_in? && current_user == user
  end

end
