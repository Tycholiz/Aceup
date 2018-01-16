class ResumesController < ApplicationController
  def create
  	@seeker = Seeker.find(params[:seeker_id])

  	@resume = @seeker.resumes.build(resume_params)
  	@resume.seeker_id = @seeker.id

  	if @resume.save
          redirect_to seeker_resumes_path, success: "Resume created successfully"
        else
          render :new
        end
  end

  def new
  	if Seeker.find(params[:seeker_id])
  		@seeker = Seeker.find(params[:seeker_id])
  	else 
  		@seeker = Seeker.where(user_id: current_user.id).first
  	end
  	
  	@resume = @seeker.resumes.build
  end

  def destroy
    @resume = Resume.find(params[:id])
    @resume.destroy
    redirect_to seekers_path, alert:  "The resume #{@resume.name} has been deleted."
  end

  def index
    @seeker = Seeker.find(params[:seeker_id])
        @resume = @seeker.resumes
  end
end

def resume_params
    params.require(:resume).permit(:title, :file)
end