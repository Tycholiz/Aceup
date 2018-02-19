class UsersController < ApplicationController
    def new
      @user = User.new
      @role = params[:role]
    end

    def edit
      @user  = User.find(params[:id])
      @role = @user.role
    end

    def create
      @user = User.new(user_params)
      @user.email = @user.email.downcase
      seeker_params = params[:seeker] if params[:seeker]

      if @user.save
        session[:user_id] = @user.id  unless current_user && current_user.role == "Admin" # auto log in 
        if current_user.role == "Seeker"
        	redirect_to new_seeker_path, notice: "Welcome aboard, #{@user.firstName}!"
        elsif current_user.role == "Employer"
        	redirect_to new_employer_path, notice: "Welcome aboard, #{@user.firstName}!"
        elsif current_user.role == "Admin"
          
          redirect_to admin_users_path, notice: "User #{@user.firstName} successfully!"
        else
          flash[:error] = @user.errors.full_messages.to_sentence
          render :new, notice: "User could not be created!"
        end
      else
        @role = params[:role]
        flash[:error] = @user.errors.full_messages.to_sentence
        render :new, notice: "User could not be created!"
      end
    end
    def update
      @user  = User.find(params[:id])
      unless @user.temp
        if @user.update_attributes(user_params) && current_user.role == "Seeker"
          @seeker = Seeker.where(user_id: @user.id).first
          redirect_to seeker_path(@seeker), notice: "Updated successfully!"
        elsif @user.update_attributes(user_params) && current_user.role == "Employer"
          @employer = Employer.where(user_id: @user.id).first
          redirect_to employer_path(@employer), notice: "Updated successfully!"
        elsif @user.update_attributes(user_params) && current_user.role == "Admin"
          redirect_to admin_users_path, notice: "Updated successfully!"
        else
          flash[:error] = @user.errors.full_messages.to_sentence
          redirect_back(fallback_location: root_path)
        end
      else @user.update_attributes(user_params) && @user.role == "Seeker"
          @seeker = Seeker.where(user_id: @user.id).first
          redirect_to edit_landing_seeker_path(@seeker), seeker_id: @seeker.id , notice: "Updated successfully!"
      # else
      #   flash[:error] = @user.errors.full_messages.to_sentence
      #   redirect_back(fallback_location: root_path)
      end
    end
 

  protected

  def user_params
    params.require(:user).permit(:temp, :seeker, :email, :firstName, :lastName, :password, :password_confirmation, :role, :phoneNo)
  end
end