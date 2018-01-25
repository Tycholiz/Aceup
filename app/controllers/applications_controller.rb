class ApplicationsController < ApplicationController

  def new
    @job = Job.find(params[:job_id])
    @seeker = Seeker.where(user_id: current_user.id).first
    

    if @job.CompUrl
      redirect_to @job.CompUrl, notice: "Adios!, #{current_user.firstName}!"
    elsif @seeker
      @application.save
      @application = @job.applications.build
      @application.seeker_id = @seeker.id
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
