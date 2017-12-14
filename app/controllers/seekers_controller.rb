class SeekersController < ApplicationController
  def new
    @seeker = seeker.new
  end

  def create
    @seeker = seeker.new(seeker_params)

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