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
    params.require(:seeker).permit(:postalCode, :educationLevel, :degree, :inSales, :outSales, :inboundSales, :outboundSales)
  end
end