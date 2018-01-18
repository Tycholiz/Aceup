class SeekersController < ApplicationController
  def new
    @seeker = Seeker.new
  end

  def create
    @seeker = Seeker.new(seeker_params)
    @seeker.user_id = current_user.id
    # @seeker.postalCode = params[:postalCode].upcase
    if @seeker.save
      redirect_to seeker_resumes_path(@seeker), success: "Welcome aboard, add a resume"
    else
      render :new
    end
  end

  def show
    @seeker = Seeker.where(user_id: current_user.id).first
    @jobs = Job.filter(params[:filter])

    @resume = @seeker.resumes.first.file_url if @seeker.resumes.first

    skillsParams = [:driversLicence, :hasVehicle, :coldCall, :doorToDoor, :custService, :acctManagment,:negotiation, :presenting, :leadership, :closing, :hunterBased, :farmerBased, :commBased, :B2C, :B2B]
    seekSkills = @seeker.slice(*skillsParams).select {|key, value| value == true }
    seekLang = @seeker.languages
    @matchJobs = Array.new
    @jobs.each do |job|
      jobSkills = job.slice(*skillsParams).select {|key, value| value == true }
      @seeker.inSales >= job.inSalesHard ? inSales = true : inSales = false
      @seeker.outSales >= job.outSalesHard ? outSales = true : outSales = false
      if job.languages
        job.languages.all? { |i| @seeker.languages.include? i } ? langMatch = true : langMatch = false
      else
        langMatch = true
      end
      if job.certifications
        job.certifications.all? { |i| @seeker.certifications.include? i } ? certMatch = true : certMatch = false
      else 
        certMatch = true
      end

      @matchJobs.push job if (jobSkills <= seekSkills && inSales && outSales && langMatch && certMatch)


    end
    @matchJobs = Kaminari.paginate_array(@matchJobs).page(params[:page]).per(10) 

  end

  def edit
    @seeker  = Seeker.find(params[:id])
  end

  def public
    @seeker  = Seeker.find(params[:id])
    @user = User.where(id: @seeker.user_id).first
    app_id = params[:application]
    @application = Application.where(id: app_id).first
    @resume = Resume.where(id: @application.resume).first
    skillsParams = [:driversLicence, :hasVehicle, :coldCall, :doorToDoor, :custService, :acctManagment,:negotiation, :presenting, :leadership, :closing, :hunterBased, :farmerBased, :commBased, :B2C, :B2B]
    @seekSkills = @seeker.slice(*skillsParams).select {|key, value| value == true }
  end

   def update
    @seeker = Seeker.find(params[:id])

    if @seeker.update_attributes(seeker_params)
      redirect_to seeker_resumes_path(@seeker), notice: "Update your resume?"
    else
      render :edit
    end
  end

  def applied
    @seeker  = Seeker.find(params[:id])
    @applications = Application.where(seeker_id: @seeker.id)
    @appliedJobs = Array.new
    @applications.each do |app|
      job = Job.where(id: app.job_id).first
      @appliedJobs.push job
    end
  end

  def saved_jobs
    @seeker  = Seeker.find(params[:id])
    @savedJobsSeeker = SavedJob.where(seeker_id: @seeker.id)
    @savedJobsList = Array.new
    @savedJobsSeeker.each do |saved|
      job = Job.where(id: saved.job_id).first
      @savedJobsList.push job
    end
  end

  protected

  def seeker_params
    params.require(:seeker).permit(:postalCode, :educationLevel, :degree, :driversLicence, :hasVehicle, :inSales, :outSales, :inboundSales, :outboundSales, :coldCall, :doorToDoor, :custService, :acctManagment, :negotiation, :presenting, :leadership, :closing, :hunterBased, :farmerBased, :commBased, :B2C, :B2B, :consSales, :directSales, :solutionSales, :certifications => [], :languages => [])
  end
end