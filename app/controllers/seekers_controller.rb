class SeekersController < ApplicationController
  def new
    @seeker = Seeker.new
  end

  def create
    @seeker = Seeker.new(seeker_params)
    @seeker.user_id = current_user.id
    @seeker.postalCode = @seeker.postalCode.upcase
    unless @seeker.postalCode.first == "V"
      @user = User.where(id: @seeker.user_id).first
      @user.out_area = true
      @user.save
    end
    if current_user.role == "Admin"  && @seeker.save  
        redirect_to admin_seekers_path, notice: "#{@seeker.id} successfully!"
    elsif @seeker.save
      redirect_to seeker_path(@seeker), success: "Welcome aboard, add a resume"
    else
      # flash[:error] = @seeker.errors.full_messages.to_sentence
      
      render :new, error: "#{@seeker.errors.count} errors prevented this profile from being created"
    end
  end

  def show
    @seeker = Seeker.where(user_id: current_user.id).first
    # unless @seeker.postalCode.first == "V"
    #   redirect_to "/pages/new_area"
    # end

    
    @jobs = Job.filter(params[:filter_years], params[:filter_salary])

    @resume = @seeker.resumes.first.file_url if @seeker.resumes.first

    
    skillsParams = [:driversLicence, :hasVehicle, :coldCall, :doorToDoor, :custService, :acctManagment,:negotiation, :presenting, :leadership, :closing, :hunterBased, :farmerBased, :commBased, :B2C, :B2B]
    @seekSkills = @seeker.slice(*skillsParams).select {|key, value| value == true }
    seekLang = @seeker.languages
    @matchJobs = Array.new
    @jobs.each do |job|
      
      jobSkills = job.slice(*skillsParams).select {|key, value| value == true }
      if job.general
        # seekerSalesYears = @seeker.inSales > @seeker.outSales ? @seeker.inSales : @seeker.outSales
        seekerSalesYears = @seeker.inSales + @seeker.outSales
        seekerSalesYears >= job.inSalesHard ? inSales = true : inSales = false
        seekerSalesYears >= job.outSalesHard ? outSales = true : outSales = false
      else 
        @seeker.inSales >= job.inSalesHard ? inSales = true : inSales = false
        @seeker.outSales >= job.outSalesHard ? outSales = true : outSales = false
      end
      if job.languages
        job.languages.all? { |i| @seeker.languages.include? i } ? langMatch = true : langMatch = false
      else
        langMatch = true
      end

      job.educationLevel.to_int <= @seeker.educationLevel.to_int ? educationMatch = true : educationMatch = false
        
      # logger.info "Seeker Skills"
      # logger.info @seekSkills
      # logger.info "Job Skills"
      # logger.info jobSkills
      # if job.general
      #  logger.info "Job Years XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
      # logger.info job.inSalesHard
      # logger.info job.inSalesHard
      # logger.info "in sales" 
      # logger.info inSales
      # logger.info "out sales" 
      # logger.info outSales
      # logger.info "General?"
      # logger.info job.general
      # end

      if job.certifications
        job.certifications.all? { |i| @seeker.certifications.include? i } ? certMatch = true : certMatch = false
      else 
        certMatch = true
      end

      if params[:filter_skills]
        filter_skills_test = params[:filter_skills].any? {|s| jobSkills.key? s}
        @matchJobs.push job if (jobSkills <= @seekSkills &&! filter_skills_test && inSales && outSales && langMatch && certMatch && educationMatch)
      else
        @matchJobs.push job if (jobSkills <= @seekSkills && inSales && outSales && langMatch && certMatch && educationMatch)
      end    
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
    @seeker.postalCode = @seeker.postalCode.upcase

    if @seeker.update_attributes(seeker_params) && current_user.role == "Seeker" 
      redirect_to seeker_path(@seeker), notice: "Updated successfully!"
    elsif @seeker.update_attributes(seeker_params) && current_user.role == "Admin"
      redirect_to admin_seekers_path, notice: "Updated successfully!"
    else
      flash[:error] = @seeker.errors.full_messages.to_sentence
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

   def no_resume
    @seeker  = Seeker.find(params[:id])
    @job = Job.find(params[:job_id])
  end

  protected

  def seeker_params
    params.require(:seeker).permit(:postalCode, :educationLevel, :degree, :driversLicence, :hasVehicle, :inSales, :outSales, :inboundSales, :outboundSales, :coldCall, :doorToDoor, :custService, :acctManagment, :negotiation, :presenting, :leadership, :closing, :hunterBased, :farmerBased, :commBased, :B2C, :B2B, :consSales, :directSales, :solutionSales, :certifications => [], :languages => [])
  end
end         