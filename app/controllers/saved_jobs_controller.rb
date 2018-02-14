class SavedJobsController < ApplicationController
  def new
    if current_user
    	@job = Job.friendly.find(params[:job_id])
      @seeker = Seeker.where(user_id: current_user.id).first
      if @seeker
        @saved_job = @job.saved_jobs.build
        @saved_job.seeker_id = @seeker.id
        @saved_job.save
        redirect_to seeker_path(@seeker), notice: "Saved job created, #{current_user.firstName}!"
       else
        flash[:alert] = "You need to be a signed in Job Hunter to save jobs!"
        redirect_back(fallback_location: root_path)
      end
     else
      flash[:alert] = "You need to be a signed in Job Hunter to save jobs!"
      redirect_back(fallback_location: root_path)
    end

  end

  def create
    @seeker = Seeker.where(user_id: current_user.id).first
    if @saved_job.save
    redirect_to saved_jobs_seeker_path, notice: "Saved job created, #{current_user.firstName}!"
    else
      render :new, notice: "Saved job unsuccessful, #{current_user.firstName}!"
    end
   end

  def destroy
  	@seeker = Seeker.where(user_id: current_user.id).first
  	@saved_job = SavedJob.find(params[:id])
    @saved_job.destroy
    flash[:alert] = "Saved job deleted, #{current_user.firstName}!"
    redirect_to saved_jobs_seeker_path(@seeker)
  end

  def update
  	@seeker = Seeker.where(user_id: current_user.id).first
  	redirect_to seeker_path(@seeker), notice: "Saved job Updated, #{current_user.firstName}!"
  end
end


   