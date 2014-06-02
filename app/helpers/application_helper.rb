module ApplicationHelper
  def app_version
    Rails.application.config.app_version
  end

  def app_name
    Rails.application.class.to_s.split("::").first
  end
end
