class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to jobs_path
    else
      render :new
    end
  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstName, :lastName, :password, :password_confirmation, :phoneNo, :postalCode, :inSales, :outSales, :inboundSales, :outboundSales)
  end
end
