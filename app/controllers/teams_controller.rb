class TeamsController < ApplicationController
	before_filter :signed_in_user
	def index
		@teams = current_user.teams.paginate(page: params[:page])
		@team = Team.new
		@user = current_user
	end
	
	def new
	end
	
	def create
		begin  
			@team = params[:team]
			@n = current_user.teams.new(@team)
			if	@n.save
				flash.now[:success]="Team #{@team[:name]} created."
			
			else
				flash.now[:error]="Failed to Create Team #{@team[:name]}. Duplicate Team Names are not allowed."
			end
			respond_to do |format|
		  		format.html { redirect_to teams_path }
		  		format.js do
		  			@teams = current_user.teams.paginate(page: params[:page])
				
		  		end
			end
			
    	rescue Exception => exception
	  		flash.now[:error]="Failed to Create Team: #{@team[:name]}: #{exception.message} "
			respond_to do |format|
		  		format.html { redirect_to teams_path }
		  		format.js do
		  			@teams = current_user.teams.paginate(page: params[:page])
				
		  		end
			end
			
		end	
	end
	
	def show
		@team = current_user.teams.find(params[:id])
	end
end
