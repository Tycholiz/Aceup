class Admin::JobsController < Admin::BaseAdminController
	def index
    	@jobs = Job.all
    	# @jobs = Kaminari.paginate_array(@jobs).page(params[:page]).per(10) 
    	@jobs = @jobs.order(:created_at).reverse_order.page(params[:page]).per(15) 
    	# @products = Product.order("name").page(params[:page]).per(5)
  	end
end
