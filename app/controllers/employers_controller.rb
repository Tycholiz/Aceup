class EmployersController < ApplicationController
  def new
    @employer = Employer.new
  end

  def create
    @employer = Employer.new(employer_params)
    @employer.user_id = current_user.id

    if @employer.save
      redirect_to employer_path(@employer), notice: "Welcome aboard"
    else
      render :new
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

    if @employer.update_attributes(employer_params)
      redirect_to employer_path(@employer)
    else
      render :edit
    end
  end

  protected

  def employer_params
    params.require(:employer).permit(:compName, :compSize, :city, :logo, :compDesc)
  end
end