class Admin::JobsController < Admin::BaseAdminController
	def index
    	@jobs = Job.all
    	@jobs = @jobs.order(:created_at).reverse_order.page(params[:page]).per(15) 
  	end

  	def activate 
	    @job = Job.find(params[:id])
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

	  # def edit
	  #   @job = Job.find(params[:id])
	  # end

	  # def create
	  #   @job = Job.new(job_params)
	  #   employer = Employer.where(user_id: current_user.id).first
	  #   @job.employer_id = employer.id
	  #   @job.status = "active"
	  #   @job.expiry = Time.now.advance(weeks: 4)

	  #   if @job.save
	  #     redirect_to employer_path(employer), notice: "#{@job.title} was submitted successfully!"
	  #   else
	  #     flash[:error] = "#{@job.errors.count} errors prevented this job from being created"
	  #     render :new
	  #   end
	  # end

	  # def update
	  #   @job = Job.find(params[:id])
	  #   user = User.where(id: current_user.id).first

	  #   if @job.update_attributes(job_params)
	  #     redirect_to admin_jobs_path, notice: "#{@job.title} was updated successfully!"
	  #   else
	  #     flash[:error] = "#{@job.errors.count} errors prevented #{@job.title} from being updated."
	  #     render :edit
	  #   end
	  # end

  	def destroy
	    user = User.where(id: current_user.id).first
	    @job = Job.find(params[:id])
	    @job.destroy
	    redirect_to admin_jobs_path, notice: "#{@job.title} was deleted successfully!"
	  end
end
