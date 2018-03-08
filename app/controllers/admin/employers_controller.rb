class Admin::EmployersController < Admin::BaseAdminController
  helper_method :sort_column, :sort_direction

  def new
    @employer = Employer.new
  end

  # def create
  #   @employer = Employer.new(employer_params)
  #   @employer.user_id = current_user.id

  #   if @employer.save       
  #         redirect_to admin_employers_path, notice: "User #{@employer.compName} successfully!"
  #   else
  #     render :new,  notice: "Could not be created."
  #   end
  # end

  # def show
  #   @employer = Employer.find(params[:id])
  #   @jobs = Job.where(employer_id: @employer.id)
  # end

  def index

    if params[:search]
      @employers= Employer.search(params[:search])
      # @employers = @employers.order(:updated_at).reverse_order.page(params[:page]).per(15) 
    else
      @employers = Employer.all
      @employers = Employer.filter(params[:fakes])
      # @employers = @employers.order(:updated_at).reverse_order.page(params[:page]).per(15) 
    end
    if sort_column == "No. Jobs"
        @employers = @employers.joins(:user, :jobs).group(:id).order("COUNT(jobs) #{sort_direction}").page(params[:page]).per(15)
    elsif sort_column == "applications"
        @employers = @employers.joins(jobs: :applications).group(:id).order("COUNT(applications) #{sort_direction}").page(params[:page]).per(15)
      else
      @employers = @employers.joins(:user).order("#{sort_column} #{sort_direction}").page(params[:page]).per(15)
    end
  end

  def edit
    @employer = Employer.find(params[:id])
  end

  #  def update
  #   @employer = Employer.find(params[:id])

  #   if @employer.update_attributes(employer_params)
  #     redirect_to admin_employers_path, notice: "Updated successfully!"
  #   else
  #     flash[:error] = @employer.errors.full_messages.to_sentence
  #     redirect_to admin_employers_path
  #   end
  # end

  def jobs
    @employer = Employer.find(params[:id])
    @jobs = Job.where(employer_id: @employer.id)
    @jobs = @jobs.order(:created_at).reverse_order.page(params[:page]).per(15) 
  end

  def destroy
      @employer  = Employer.find(params[:id])
      @employer.destroy
      redirect_to admin_employers_path, notice: "#{@employer.compName} was deleted successfully!"
  end

  def applications
    @employer = Employer.find(params[:id])
    @jobs = Job.where(employer_id: @employer.id)
    @applications = Array.new
    @jobs.each do |job|
      @applied = Application.where(job_id: job.id)
      @applied.each do |app|
        @applications.push app if @applied.length > 0
      end
    end

  end
   def activate 
    @employer  = Employer.find(params[:id])
    if @employer.status == "active"
      @employer.status = "suspended"
    else
      @employer.status = "active"
    end
    @employer.save
    if @employer.save
      redirect_to admin_employers_path,  notice: "Employer:#{@employer.id}'s' status has been changed to #{@employer.status.capitalize}"
    else
      flash[:error] = "#{@employer.errors.count} errors prevented this job from being updated"
      redirect_to admin_employers_path
    end
  end  

  private
   def sort_column
      params[:column] ? params[:column] : "updated_at"
   end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

  # protected

  # def employer_params
  #   params.require(:employer).permit(:compName, :compSize, :city, :logo, :compDesc)
  # end
end