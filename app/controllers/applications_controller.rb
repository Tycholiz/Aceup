class ApplicationsController < ApplicationController

  def new
    @job = Job.find(params[:job_id])
    @seeker = Seeker.where(user_id: current_user.id).first
    @resumes = Resume.where(seeker_id: 1)
    @resumeTest = @resumes.count

    

    if @job.CompUrl
      redirect_to @job.CompUrl, notice: "Good luck!, #{current_user.firstName}!"
    elsif @seeker && @resumeTest > 0
      @application = @job.applications.build
      @application.seeker_id = @seeker.id
      @application.save
    elsif @seeker && @resumeTest < 1
      flash[:alert] = "No RESUME!"
      redirect_to no_resume_seeker_path(@seeker, job_id: @job.id)
    else
      flash[:alert] = "You need to be a Job Hunter to apply for jobs!"
      redirect_back(fallback_location: root_path)
    # @application = Application.new(job_id: @job.id)
    end
  end

  def create
    @job = Job.find(params[:job_id])
    @application = Application.where(job_id: @job.id).first
    if @application.save
      @seeker = Seeker.where(user_id: current_user.id).first
      redirect_to seeker_path(@seeker), notice: "Application Saved, #{current_user.firstName}!"
    else 
      render :new
      flash[:error] = @application.errors.full_messages.to_sentence
    end
    if @application.errors.any?
      @application.errors.full_messages.each do |msg|
        flash[:error] = msg
      end
    end
  end

  def delete
  end

  def update
    @application = Application.find(params[:id])
    @seeker = Seeker.where(user_id: current_user.id).first
    # @application.resume = params[:resume]
    @application.update_attributes(params.require(:application).permit(:resume))
    redirect_to seeker_path(@seeker), notice: "Application Updated, #{current_user.firstName}!"
  end
end
