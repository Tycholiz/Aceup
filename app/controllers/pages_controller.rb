class PagesController < ApplicationController
    def show
    	render template: "pages/#{params[:page]}"
    end

    def landing
    	if current_user
	    	if current_user.role == "Admin" 
	    		redirect_to admin_users_path, notice: "Welcome back Admin!"
	    	elsif current_user.role == "Seeker" 
	    		@seeker = Seeker.where(user_id: current_user.id).first
	        	redirect_to seeker_path(@seeker), notice: "Welcome back!"
	    	elsif current_user.role == "Employer" 
	    		@employer = Employer.where(user_id: current_user.id).first
	        	redirect_to employer_path(@employer), notice: "Welcome back!"
	        end
        else
    		render "landing" 
    	end 
    end
  end  