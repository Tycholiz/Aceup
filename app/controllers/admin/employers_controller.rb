class Admin::EmployersController < Admin::BaseAdminController

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
      @employers = @employers.order(:updated_at).reverse_order.page(params[:page]).per(15) 
    else
      @employers = Employer.all
      @employers = Employer.filter(params[:fakes])
      @employers = @employers.order(:updated_at).reverse_order.page(params[:page]).per(15) 
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

  protected

  def employer_params
    params.require(:employer).permit(:compName, :compSize, :city, :logo, :compDesc)
  end
end