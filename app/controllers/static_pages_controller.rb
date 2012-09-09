class StaticPagesController < ApplicationController
	def home
		if signed_in?
			@micropost = current_user.microposts.build 
			@feed_items = current_user.feed.paginate(page: params[:page])
			@stacks = current_user.stacks.paginate(page: params[:stacks_page])
			@teams = current_user.teams.paginate(page: params[:teams_page])
			@user = current_user
		end
    	
	end
  	
  	def help
  	end

	def about
	end
	
	def contact
	end
end
