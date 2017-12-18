class UsersController < ApplicationController
  def new
    @user = User.new
    @role = params[:role]
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id # auto log in
      if @user.role == "Seeker"
      	redirect_to new_seeker_path, notice: "Welcome aboard, #{@user.firstName}!"
      elsif @user.role == "Employer"
      	redirect_to new_employer_path, notice: "Welcome aboard, #{@user.firstName}!"
      else
      	redirect_to jobs_path, notice: "Welcome aboard, #{@user.firstName}!"
      end
    else
      render :new
    end
  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstName, :lastName, :password, :password_confirmation, :phoneNo, :role)
  end
end