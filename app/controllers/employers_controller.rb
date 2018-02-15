class EmployersController < ApplicationController
  def new
    @employer = Employer.new
  end

  def create
    @employer = Employer.new(employer_params)
    @employer.user_id = current_user.id
    @employer.status = "active"

    if current_user.role == "Admin"  && @employer.save       
          redirect_to admin_employers_path, notice: "#{@employer.compName} successfully!"
    elsif @employer.save
      redirect_to employer_path(@employer), notice: "Welcome aboard"
    else
      render :new,  notice: "Could not be created."
    end
  end

  def show
    @employer = Employer.find(params[:id])
    @jobs = Job.where(employer_id: @employer.id)
  end

  def edit
    @employer = Employer.find(params[:id])
  end

   def update
    @employer = Employer.find(params[:id])

    if @employer.update_attributes(employer_params) && current_user.role == "Employer" 
      redirect_to employer_path(@employer)
    elsif @employer.update_attributes(employer_params) && current_user.role == "Admin" 
      redirect_to admin_employers_path, notice: "Updated successfully!"
    else
      render :edit
    end
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
    params.require(:employer).permit(:compName, :compSize, :city, :logo, :compDesc, :metro)
  end
end