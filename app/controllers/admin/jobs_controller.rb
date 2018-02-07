class Admin::JobsController < Admin::BaseAdminController
	def index
    	@jobs = Job.all
    	@jobs = @jobs.order(:created_at).reverse_order.page(params[:page]).per(15) 
  	end

  	def activate 
	    @job = Job.friendly.find(params[:id])
	    user = User.where(id: current_user.id).first
	    if @job.status == "active"
	      @job.status = "inactive"
	    else
	      @job.status = "active"
	    end
	    if @job.save
	      redirect_to admin_jobs_path,  notice: "#{@job.title} status has been changed to #{@job.status.capitalize}"
	    else
	      flash[:error] = "#{@job.errors.count} errors prevented this job from being updated"
	      redirect_to admin_jobs_path
	    end
  	end

	  def new
	    @job = Job.new
	    @employers = Employer.all
	    @emp_list = Array.new
	    @employers.each do |emp|
	    	@emp_list.push([emp.compName, emp.id])
	    end
	    logger.info @emp_list
	  end

  	def destroy
	    user = User.where(id: current_user.id).first
	    @job = Job.friendly.find(params[:id])
	    @job.destroy
	    redirect_to admin_jobs_path, notice: "#{@job.title} was deleted successfully!"
	  end
end
