module ApplicationHelper

  def error_notices(error_resource)
    error_resource.errors.each do |error|
      "<li>#{error}</li>"
    end
  end

end
