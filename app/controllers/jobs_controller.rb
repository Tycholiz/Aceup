class JobsController < ApplicationController
  # def index
  # end

  # def show
  # end

  # def new
  # end

  # def edit
  # end

   def index
	 @jobs = Job.all
   end

  def show
    @job = Job.find(params[:id])
  end

  def new
    @job = Job.new
  end

  def edit
    @job = Job.find(params[:id])
  end

  def create
    @job = Job.new(job_params)

    if @job.save
      redirect_to jobs_path
    else
      render :new
    end
  end

  def update
    @job = Job.find(params[:id])

    if @job.update_attributes(job_params)
      redirect_to job_path(@job)
    else
      render :edit
    end
  end

  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    redirect_to jobs_path
  end

  protected

  def job_params
    params.require(:job).permit(
      :title, :type, :payLow, :payHigh, :skills, :summary
    )
  end



end
