class JobsController < ApplicationController
  def index
	  @jobs = Job.all
    unless current_user
      redirect_to new_user_path
    end
    if current_user.role == "Seeker"
      seeker = Seeker.where(user_id: current_user.id).first.attributes
      seekSkills = seeker.select {|key, value| value == true }
      @matchJobs = Array.new
      @jobs.each do |job|
        jobSkills = job.attributes.select {|key, value| value == true }
        jobSkills.delete("temp") #should change temp to something else in database

        @matchJobs.push job if (jobSkills <= seekSkills)

      end
    end



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
    employer = Employer.where(user_id: current_user.id).first
    @job.employer_id = employer.id

    if @job.save
      redirect_to jobs_path, notice: "#{@job.title} was submitted successfully!"
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
      :title, :jobType, :expiry, :status, :temp, :salary, :payLow, :payHigh, :inSalesSoft, :inSalesHard, :outSalesSoft, :outSalesHard, :functions, :skills, :summary, :competencies, :deptSize, :benefits, :coldCall, :doorToDoor, :custService, :acctManagment, :negotiation, :presenting, :leadership, :closing, :hunterBased, :farmerBased, :commBased, :B2C, :B2B, :consSales, :directSales, :solutionSales
    )
  end

end