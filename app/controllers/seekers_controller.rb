class SeekersController < ApplicationController
  def new
    if params[:seeker]
      @seeker = Seeker.new(params[:seeker])
    end
    @seeker = Seeker.new
  end

  def create
    @seeker = Seeker.new(seeker_params)
    if @seeker.temp
      @user = User.new
      @user.temp = true
      @user.password = "testtest"
      @user.password_confirmation = "testtest"
      @user.role = "Landing"
      @user.save
      if @user.save
        session[:user_id] = @user.id  unless current_user && current_user.role == "Admin" # auto log in 
      end

      @seeker.user_id = @user.id
      @seeker.status = "pending"
      if @seeker.save
        # redirect_to controller: 'users', action: 'edit', id: @user.id, landing: "#{@seeker.id}"
        # redirect_to edit_landing_seeker_path(@seeker), seeker_id: @seeker.id , notice: "Updated successfully!"
        redirect_to edit_landing_seeker_path(@seeker), notice: "Updated successfully!"
     else   
        render :new, error: "#{@seeker.errors.count} errors prevented this profile from being created"
      end
    else
      @seeker.user_id = current_user.id
      @seeker.postalCode = @seeker.postalCode.upcase
      @seeker.status = "active"
      unless @seeker.postalCode.first == "V" || @seeker.postalCode.first == "M" || @seeker.postalCode.first == "L"
        @user = User.where(id: @seeker.user_id).first
        @user.out_area = true
        @user.save
      end
      if current_user.role == "Admin"  && @seeker.save  
          redirect_to admin_seekers_path, notice: "#{@seeker.id} successfully!"
      elsif @seeker.save
        redirect_to seeker_path(@seeker), success: "Welcome aboard, add a resume"
      else
        flash[:error] = @seeker.errors.full_messages.to_sentence
        render :new, error: "#{@seeker.errors.count} errors prevented this profile from being created"
      end
    end
  end

  def show
    if current_user
      @seeker = Seeker.where(user_id: current_user.id).first
    elsif params[:seeker_id]
      @seeker = Seeker.where(user_id: params[:seeker_id]).first
    end
    # unless @seeker.postalCode.first == "V"
    #   redirect_to "/pages/new_area"
    # end

    unless @seeker.temp

        @jobs = Job.filter(params[:filter_years], params[:filter_salary]).order(:created_at).reverse_order

        @resume = @seeker.resumes.first.file_url if @seeker.resumes.first

        case @seeker.postalCode.first
            when "V"
              seek_metro = "Van"
            when "M"
              seek_metro = "Tor"
            when "L"
              seek_metro = "Tor"
            else
              seek_metro = "N/A"
        end

        
        skillsParams = [:driversLicence, :hasVehicle, :coldCall, :doorToDoor, :custService, :acctManagment,:negotiation, :presenting, :leadership, :closing, :hunterBased, :farmerBased, :commBased, :B2C, :B2B]
        aspectsParams = [ :AspProspecting,
                          :AspcoldCall,
                          :AspdoorToDoor, 
                          :AspWarmLeads,
                          :AspNetworking, 
                          :AspPresenting, 
                          :AspClosing,
                          :AspNegotiation,
                          :AspacctManagment,
                          :AspB2B,
                          :AspB2C,
                          :AspInSales,
                          :AspOutSales,
                          :AspInbound,
                          :AspOutbound,
                          :AspOvernight,
                          :AspLocal
                        ]

        @seekSkills = @seeker.slice(*skillsParams).select {|key, value| value == true }
        seekLang = @seeker.languages
        @matchJobs = Array.new
        @jobs.each do |job|
          employer = Employer.where(id: job.employer_id).first
          case employer.metro
            when "Vancouver"
              job_metro = "Van"
            when "Toronto"
              job_metro = "Tor"
            else
              job_metro = "N/A"
          end

          seek_metro == job_metro ? metroMatch = true : metroMatch = false

          jobSkills = job.slice(*skillsParams).select {|key, value| value == true }
          @jobApects = job.slice(*aspectsParams).select {|key, value| value == true }
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
            logger.info @jobApects
            asptest = params[:filter_aspects]
            logger.info asptest
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

          matchQuery = jobSkills <= @seekSkills && inSales && outSales && langMatch && certMatch && educationMatch && metroMatch
          if params[:filter_skills] && params[:filter_aspects]
            filter_skills_test = params[:filter_skills].any? {|s| jobSkills.key? s}
            aspects_test = params[:filter_aspects].any? {|s| @jobApects.key? s}
            @matchJobs.push job if ( matchQuery &&! filter_skills_test  &&! aspects_test)
          elsif params[:filter_aspects]
            aspects_test = params[:filter_aspects].any? {|s| @jobApects.key? s}
            @matchJobs.push job if ( matchQuery &&! aspects_test)
          elsif params[:filter_skills]
            filter_skills_test = params[:filter_skills].any? {|s| jobSkills.key? s}
            @matchJobs.push job if ( matchQuery &&! filter_skills_test)
          else
            @matchJobs.push job if (matchQuery)
          end    
        end
        @matchJobs = Kaminari.paginate_array(@matchJobs).page(params[:page]).per(10) 
      else
        flash[:error] = @seeker.errors.full_messages.to_sentence
        redirect_to("/pages/construction")
      end

    end

    def edit
      @seeker  = Seeker.find(params[:id])
    end

    def edit_landing
      @seeker  = Seeker.find(params[:id])
    end

    def public
      @seeker  = Seeker.find(params[:id])
      @user = User.where(id: @seeker.user_id).first
      app_id = params[:application]
      @application = Application.where(id: app_id).first
      @resume = Resume.where(id: @application.resume).first
      logger.info @application
      logger.info @resume
      skillsParams = [:driversLicence, :hasVehicle, :coldCall, :doorToDoor, :custService, :acctManagment,:negotiation, :presenting, :leadership, :closing, :hunterBased, :farmerBased, :commBased, :B2C, :B2B]
      @seekSkills = @seeker.slice(*skillsParams).select {|key, value| value == true }
    end

     def update
      @seeker = Seeker.find(params[:id])
      
      # @seeker.postalCode = @seeker.postalCode.upcase if @seeker.postalCode
      @seeker.inSales  = @seeker.inSales.to_f
      @seeker.outSales  = @seeker.outSales.to_f
      # if @seeker.temp
      if  @seeker.status == "pending"
        @seeker.temp = false
        @seeker.save
        # @user = User.where(id: @seeker.user_id).first
        # @user.temp = false
        # @user.role = "Seeker"
        # @user.save
        # @seeker.temp = false
        if @seeker.update_attributes(seeker_params)
          @seeker.status = "active"
          @seeker.save
          redirect_to controller: 'users', action: 'edit', id: @seeker.user_id
        else
          # flash[:error] = @seeker.errors.full_messages.to_sentence
          render :edit_landing
        end
      else


        if @seeker.update_attributes(seeker_params) && current_user.role == "Seeker" 
          redirect_to seeker_path(@seeker), notice: "Updated successfully!"
        elsif @seeker.update_attributes(seeker_params) && current_user.role == "Admin"
          redirect_to admin_seekers_path, notice: "Updated successfully!"
        else
          flash[:error] = @seeker.errors.full_messages.to_sentence
          render :edit
        end
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
      if @seeker
        @savedJobsSeeker = SavedJob.where(seeker_id: @seeker.id)
        @savedJobsList = Array.new
        @savedJobsSeeker.each do |saved|
          job = Job.where(id: saved.job_id).first
          @savedJobsList.push job
        end
    else
      flash[:alert] = "You need to be a signed in Job Hunter to save jobs!"
      redirect_back(fallback_location: root_path)
    end
  end

   def no_resume
    @seeker  = Seeker.find(params[:id])
    @job = Job.find(params[:job_id])
  end

  protected

  def seeker_params
    params.require(:seeker).permit(:temp, :postalCode, :educationLevel, :degree, :driversLicence, :hasVehicle, :inSales, :outSales, :inboundSales, :outboundSales, :coldCall, :doorToDoor, :custService, :acctManagment, :negotiation, :presenting, :leadership, :closing, :hunterBased, :farmerBased, :commBased, :B2C, :B2B, :consSales, :directSales, :solutionSales, :certifications => [], :languages => [])
  end
end         