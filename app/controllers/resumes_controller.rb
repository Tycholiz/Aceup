class ResumesController < ApplicationController
  def create
  	@seeker = Seeker.find(params[:seeker_id])

  	@resume = @seeker.resumes.build(resume_params)
  	@resume.seeker_id = @seeker.id
    @job = Job.friendly.find(params[:job_id]) if params[:job_id]
  	if @resume.save && @job
          redirect_to new_job_application_path(@job), success: "Resume created successfully"
    elsif @resume.save
          redirect_to seeker_resumes_path, success: "Resume created successfully"
    else
      render :new, alert:  "Resume not created, Errors"
    end
  end

  def new   
    @job = Job.friendly.find(params[:job_id])  if params[:job_id]
  	if Seeker.find(params[:seeker_id])
  		@seeker = Seeker.find(params[:seeker_id])
  	else 
  		@seeker = Seeker.where(user_id: current_user.id).first
  	end
  	
  	@resume = @seeker.resumes.build
  end

  def destroy
    if Seeker.find(params[:seeker_id])
      @seeker = Seeker.find(params[:seeker_id])
    else 
      @seeker = Seeker.where(user_id: current_user.id).first
    end
    @resume = Resume.find(params[:id])
    @resume.destroy
    redirect_to seeker_resumes_path(@seeker), alert:  "The resume #{@resume.title} has been deleted."
  end

  def index
    @seeker = Seeker.find(params[:seeker_id])
        @resume = @seeker.resumes
  end
   
end

def resume_params
    params.require(:resume).permit(:title, :file, :job_id)
end