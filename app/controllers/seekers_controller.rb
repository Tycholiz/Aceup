class SeekersController < ApplicationController
  def new
    @seeker = Seeker.new
  end

  def create
    @seeker = Seeker.new(seeker_params)
    @seeker.user_id = current_user.id

    if @seeker.save
      redirect_to jobs_path, notice: "Welcome aboard"
    else
      render :new
    end
  end

  protected

  def seeker_params
    params.require(:seeker).permit(:postalCode, :educationLevel, :degree, :inSales, :outSales, :inboundSales, :outboundSales, :coldCall, :doorToDoor, :custService, :acctManagment, :negotiation, :presenting, :leadership, :closing, :hunterBased, :farmerBased, :commBased, :B2C, :B2B, :consSales, :directSales, :solutionSales)
  end
end