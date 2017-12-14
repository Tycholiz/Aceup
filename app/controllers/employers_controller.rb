class EmployersController < ApplicationController
  def new
    @employer = Employer.new
  end

  def create
    @employer = Employer.new(employer_params)
    @employer.user_id = current_user.id

    if @employer.save
      redirect_to jobs_path, notice: "Welcome aboard"
    else
      render :new
    end
  end

  protected

  def employer_params
    params.require(:employer).permit(:compName, :compSize, :city, :logo, :compDesc)
  end
end