class Admin::DashboardController < Admin::BaseAdminController
	def landing
    	@users = User.all
  	end
end
