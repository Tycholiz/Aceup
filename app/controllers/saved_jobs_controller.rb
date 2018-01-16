class SavedJobsController < ApplicationController
  def new
  	@job = Job.find(params[:job_id])
    @seeker = Seeker.where(user_id: current_user.id).first
    @saved_job = @job.saved_jobs.build
    @saved_job.seeker_id = @seeker.id
    @saved_job.save
  end

  def create
  	@seeker = Seeker.where(user_id: current_user.id).first
    redirect_to seeker_path(@seeker), notice: "Job Saved, #{current_user.firstName}!"
  end

  def delete
  end

  def update
  end
end


   