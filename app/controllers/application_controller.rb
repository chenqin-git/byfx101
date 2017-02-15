class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def check_permission!
    if !current_user.is_admin?
      redirect_to root_path, alert: "你无权限登录后台"
    end
  end
end
