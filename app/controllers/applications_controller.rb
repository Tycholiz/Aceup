class ApplicationsController < ApplicationController

  def new
    @job = Job.find(params[:job_id])
    @seeker = Seeker.where(user_id: current_user.id).first
    @application = @job.applications.build
    @application.seeker_id = @seeker.id
    ## Add code for user to choose resume
    @application.save

    # @application = Application.new(job_id: @job.id)
  end

  def create
  	# seeker = Seeker.where(user_id: current_user.id).first
  	# @job = Job.find(params[:job_id])
  	# @application = @job.applications.build
  	# ## Add code for user to choose resume
  	# @application.seeker_id = seeker.id
    @seeker = Seeker.where(user_id: current_user.id).first
    redirect_to seeker_path(@seeker), notice: "Application Saved, #{current_user.firstName}!"
  end

  def delete
  end

  def update
    @seeker = Seeker.where(user_id: current_user.id).first
    redirect_to seeker_path(@seeker), notice: "Application Saved, #{current_user.firstName}!"
  end
end
