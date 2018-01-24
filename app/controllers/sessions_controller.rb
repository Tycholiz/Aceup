class SessionsController < ApplicationController

    def new
    end

    def create
      user = User.find_by(email: params[:email].downcase)

      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        if user.role == "Employer"
          employer = Employer.where(user_id: current_user.id).first
          redirect_to employer_path(employer), success: "Welcome back, #{user.firstName}!"
        else 
          seeker = Seeker.where(user_id: current_user.id).first
          redirect_to seeker_path(seeker), success: "Welcome back, #{user.firstName}!"
        end
      else
        flash.now[:alert] = "Log in failed..."
        render :new
      end
    end

    def destroy
      session[:user_id] = nil
      redirect_to "/pages/logout", notice: "Adios!"
    end
end