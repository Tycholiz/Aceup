class Admin::BaseAdminController < ActionController::Base
	 # use an admin-specific layout instead of the main application layout
  layout "admin" 

  # all child controllers will automatically enforce access to admins only
  before_action :require_admin
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  def require_admin
    redirect_to root_path, notice: "You need to be an admin to access that page!" unless current_user && current_user.role == "Admin" 
  end
end
