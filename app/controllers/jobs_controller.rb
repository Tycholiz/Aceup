class JobsController < ApplicationController

  impressionist actions: [:show], unique: [:impressionable_id, :session_hash]

  def index
	  @jobs = Job.all
    unless current_user
      redirect_to root_path
    else
      if current_user.role == "Seeker"
        seeker = Seeker.where(user_id: current_user.id).first.attributes
        seekSkills = seeker.select {|key, value| value == true }
        @matchJobs = Array.new
        @jobs.each do |job|
          jobSkills = job.attributes.select {|key, value| value == true }
          jobSkills.delete("temp") #should change temp to something else in database

          @matchJobs.push job if (jobSkills <= seekSkills)

        end
        @matchJobs = Kaminari.paginate_array(@matchJobs).page(params[:page]).per(10) 
      end
    end


  end

  def show
    @job = Job.find(params[:id])
    @employer = Employer.where(id: @job.employer_id).first
    if current_user.role == "Seeker"
        @seeker = Seeker.where(user_id: current_user.id).first
    end
    skillsParams = [:driversLicence, :hasVehicle, :coldCall, :doorToDoor, :custService, :acctManagment,:negotiation, :presenting, :leadership, :closing, :hunterBased, :farmerBased, :commBased, :B2C, :B2B]
    @jobSkills = @job.slice(*skillsParams).select {|key, value| value == true }

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
    @job.status = "active"
    @job.expiry = Time.now.advance(weeks: 4)

    if @job.save
      redirect_to employer_path(employer), notice: "#{@job.title} was submitted successfully!"
    else
      flash[:alert] = "#{@job.title} could not be created."
      render :new
    end
  end

  def update
    @job = Job.find(params[:id])
    user = User.where(id: current_user.id).first
    employer = Employer.where(user_id: user.id).first

    if @job.update_attributes(job_params)
      redirect_to employer_path(employer), notice: "#{@job.title} was updated successfully!"
    else
      flash[:alert] = "#{@job.title} could not be created."
      render :edit
    end
  end

  def destroy
    user = User.where(id: current_user.id).first
    employer = Employer.where(user_id: user.id).first
    @job = Job.find(params[:id])
    @job.destroy
    redirect_to employer_path(employer), notice: "#{@job.title} was deleted successfully!"
  end

  protected

  def job_params
    params.require(:job).permit(
      :title, :jobType, :expiry, :driversLicence, :hasVehicle, :status, :temp, :salary, :payLow, :payHigh, :inSalesSoft, :inSalesHard, :outSalesSoft, :outSalesHard, :functions, :skills, :summary, :competencies, :deptSize, :benefits, :coldCall, :doorToDoor, :custService, :acctManagment, :negotiation, :presenting, :leadership, :closing, :hunterBased, :farmerBased, :commBased, :B2C, :B2B, :consSales, :directSales, :solutionSales, :CompUrl, :languages => [], :certifications => []
    )                             
  end

end