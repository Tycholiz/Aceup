class JobsController < ApplicationController

  # impressionist actions: [:show], unique: [:impressionable_id, :session_hash]

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
    @job = Job.friendly.find(params[:id])
    impressionist(@job)
    @commissions = []
    @commissions.push "Direct" if @job.commDirect
    @commissions.push "Residual" if @job.commResidual
    @commissions.push "Lead" if @job.commLead
    @commissions.push "Bonus" if @job.bonusSales
    @employer = Employer.where(id: @job.employer_id).first
    if current_user && current_user.role == "Seeker"
        @seeker = Seeker.where(user_id: current_user.id).first
    end
    skillsParams = [:driversLicence, :hasVehicle, :coldCall, :doorToDoor, :custService, :acctManagment,:negotiation, :presenting, :leadership, :closing, :hunterBased, :farmerBased, :commBased, :B2C, :B2B]
    @jobSkills = @job.slice(*skillsParams).select {|key, value| value == true }

  end

  def new
    @job = Job.new
  end

  def edit
    @job = Job.friendly.find(params[:id])
    @employers = Employer.all
      @emp_list = Array.new
      @employers.each do |emp|
        @emp_list.push([emp.compName, emp.id])
      end
  end

  def create
    @job = Job.new(job_params)
    employer = Employer.where(user_id: current_user.id).first
    if current_user.role == "Admin"
      @job.employer_id = 1
    else
      @job.employer_id = employer.id  
    end
    @job.status = "active"
    @job.expiry = Time.now.advance(weeks: 4)

    @employers = Employer.all
      @emp_list = Array.new
      @employers.each do |emp|
        @emp_list.push([emp.compName, emp.id])
      end

    if @job.save && current_user.role == "Employer" 
      redirect_to employer_path(employer), notice: "#{@job.title} was submitted successfully!"
    elsif @job.save && current_user.role == "Admin" 
      redirect_to admin_jobs_path, notice: "#{@job.title} was submitted successfully!"
    elsif  current_user.role == "Admin" 
      flash[:error] = "#{@job.errors.count} errors prevented this job from being created"
      logger.info @job.errors.full_messages.to_sentence
      render  'admin/jobs/new'
    else
      flash[:error] = "#{@job.errors.count} errors prevented this job from being created"
      logger.info @job.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    @job = Job.friendly.find(params[:id])
    user = User.where(id: current_user.id).first
    employer = Employer.where(user_id: user.id).first

    if @job.update_attributes(job_params) && employer && current_user.role == "Employer" 
      redirect_to employer_path(employer), notice: "#{@job.title} was updated successfully!"
    elsif @job.update_attributes(job_params) && current_user.role == "Admin" 
      redirect_to admin_jobs_path, notice: "#{@job.title} was updated successfully!"
    else
      flash[:error] = "#{@job.errors.count} errors prevented #{@job.title} from being updated."
      render :edit
    end
  end

  def activate 
    @job = Job.friendly.find(params[:id])
    user = User.where(id: current_user.id).first
    employer = Employer.where(user_id: user.id).first
    if @job.status == "active"
      @job.status = "inactive"
    else
      @job.status = "active"
    end
    if @job.save
      redirect_to employer_path(employer),  notice: "#{@job.title} status has been changed to #{@job.status.capitalize}"
    else
      flash[:error] = "#{@job.errors.count} errors prevented this job from being updated"
      redirect_to employer_path(employer)
    end
  end  

  def destroy
    user = User.where(id: current_user.id).first
    employer = Employer.where(user_id: user.id).first
    @job = Job.friendly.find(params[:id])
    @job.destroy
    redirect_to employer_path(employer), notice: "#{@job.title} was deleted successfully!"
  end

  protected

  def job_params
    params.require(:job).permit(
      :title, :jobType, :expiry, :bonusSales,  :additionalInfo, :general, :title_functions, :title_skills, :title_comp, :title_benefits, :driversLicence, :hasVehicle, :status, :temp, :salary, :commDirect, :commResidual, :commLead, :payLow, :payHigh, :inSalesSoft, :inSalesHard, :outSalesSoft, :outSalesHard, :functions, :skills, :summary, :competencies, :deptSize, :coldCall, :doorToDoor, :custService, :acctManagment, :negotiation, :presenting, :leadership, :closing, :hunterBased, :farmerBased, :commBased, :B2C, :B2B, :consSales, :directSales, :solutionSales, :CompUrl, :educationLevel, :benefits, :languages => [], :certifications => []
    )                             
  end

end
