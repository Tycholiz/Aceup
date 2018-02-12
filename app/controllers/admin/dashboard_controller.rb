class Admin::DashboardController < Admin::BaseAdminController
	def landing
    	@users = User.all
    	@applications = Application.order(:updated_at).reverse_order.page(params[:page]).per(5) 
  	end
end
