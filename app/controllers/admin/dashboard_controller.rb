class Admin::DashboardController < Admin::BaseAdminController
	def landing
    	@users = User.all
    	@applications = Application.order(:updated_at).page(params[:page]).per(5) 
  	end
end
