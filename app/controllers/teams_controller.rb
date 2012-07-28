class TeamsController < ApplicationController
	before_filter :signed_in_user
	
	def index
		@teams = current_user.teams.paginate(page: params[:page])
		@team = Team.new
		@user = current_user
	end
	
	def show
	end
end
