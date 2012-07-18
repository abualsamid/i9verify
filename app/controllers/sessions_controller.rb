class SessionsController < ApplicationController
	def new
		
	end
	def create
		if params[:session][:email].blank? || params[:session][:password].blank? then
			flash.now[:error]="Please complete all fields to continue. Please try again."
			render 'new'
		else
		
			user = User.find_by_email(params[:session][:email])
			if user && user.authenticate(params[:session][:password]) then
				sign_in user 
				redirect_back_or user
			else
				flash.now[:error]="Could not authenticate your request. Please try again."
				render 'new' 
			end
		end
	end 
	def destroy 
		sign_out
		redirect_to root_path
	end
end
