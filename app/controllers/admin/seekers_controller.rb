class Admin::SeekersController < Admin::BaseAdminController
  helper_method :sort_column, :sort_direction

  def new
    @seeker = Seeker.new
  end

  # def create
  #   @seeker = seeker.new(seeker_params)
  #   @seeker.user_id = current_user.id

  #   if @seeker.save       
  #         redirect_to admin_seekers_path, notice: "User #{@seeker.compName} successfully!"
  #   else
  #     render :new,  notice: "Could not be created."
  #   end
  # end

  def show
    @seeker = Seeker.find(params[:id])
    @jobs = Job.where(seeker_id: @seeker.id)
    @user = User.where(id: @seeker.user_id).first
    skillsParams = [:driversLicence, :hasVehicle, :coldCall, :doorToDoor, :custService, :acctManagment,:negotiation, :presenting, :leadership, :closing, :hunterBased, :farmerBased, :commBased, :B2C, :B2B]
    @seekSkills = @seeker.slice(*skillsParams).select {|key, value| value == true }
    @resumes = @seeker.resumes
  end

  def index

    if params[:search]
      @seekers= Seeker.search(params[:search])
      # @seekers = @seekers.order(:updated_at).reverse_order.page(params[:page]).per(15) 
      @seekers = @seekers.order("#{sort_column} #{sort_direction}").page(params[:page]).per(15)
    else
      @seekers = Seeker.all
      @seekers = Seeker.filter(params[:fakes])
       if sort_column == "applications"
        @seekers = @seekers.joins(:user, :applications).group(:id).order("COUNT(applications) DESC").page(params[:page]).per(15)
      else
        @seekers = @seekers.joins(:user).order("#{sort_column} #{sort_direction}").page(params[:page]).per(15)
      end
    end
  end

  def edit
    @seeker = Seeker.find(params[:id])
  end

  #  def update
  #   @seeker = seeker.find(params[:id])

  #   if @seeker.update_attributes(seeker_params)
  #     redirect_to admin_seekers_path, notice: "Updated successfully!"
  #   else
  #     flash[:error] = @seeker.errors.full_messages.to_sentence
  #     redirect_to admin_seekers_path
  #   end
  # end

  def job_views
    @seeker  = Seeker.find(params[:id])
    @jobs = Array.new
    user = User.where(id: @seeker.user_id).first
    views = Impression.where(user_id: user.id)
    views.each do |view|
      job = Job.where(id: view.impressionable_id).first
      @jobs.push job
    end
    @jobs = Kaminari.paginate_array(@jobs).page(params[:page]).per(10) 

  end

  def destroy
      @seeker  = Seeker.find(params[:id])
      @seeker.destroy
      redirect_to admin_seekers_path, notice: "#{@seeker.id} was deleted successfully!"
  end

  def applications
   @seeker  = Seeker.find(params[:id])
    @applications = Application.where(seeker_id: @seeker.id)
    @appliedJobs = Array.new
    @applications.each do |app|
      job = Job.where(id: app.job_id).first
      @appliedJobs.push job
    end
  end

  def activate 
    @seeker  = Seeker.find(params[:id])
    if @seeker.status == "active"
      @seeker.status = "suspended"
    else
      @seeker.status = "active"
    end
    if @seeker.save
      redirect_to admin_seekers_path,  notice: "Seeker:#{@seeker.id}'s' status has been changed to #{@seeker.status.capitalize}"
    else
      flash[:error] = "#{@seeker.errors.count} errors prevented this job from being updated"
      redirect_to admin_seekers_path
    end
  end  

  private

  # def sortable_columns
  #   ["name", "price"]
  # end

  def sort_column
    # sortable_columns.include?(params[:column]) ? params[:column] : "name"
    # if params[:column] == "postalCode"
    #   logger.info "##0###############  POSTAL   ##################"
    #   "postalCode"
    # else
      params[:column] ? params[:column] : "updated_at"
    # end
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

  # protected

  # def seeker_params
  #   params.require(:seeker).permit(:compName, :compSize, :city, :logo, :compDesc)
  # end
end