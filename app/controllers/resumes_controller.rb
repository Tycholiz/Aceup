class ResumesController < ApplicationController
  def create
  	@seeker = Seeker.find(params[:seeker_id])
  	@resume = @seeker.resumes.build(resume_params)
  	@resume.seeker_id = @seeker.id

  	if @resume.save
          redirect_to @seeker, notice: "Resume created successfully"
        else
          render :new
        end
  end

  def new
  	@seeker = Seeker.find(params[:seeker_id])
  	@resume = @seeker.resumes.build
  end

  def destroy
    @resume = Resume.find(params[:id])
    @resume.destroy
    redirect_to seekers_path
  end
end

def resume_params
    params.require(:resume).permit(:title, :file)
end