class MicropostsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user,   only: :destroy

	def create
		@micropost = current_user.microposts.build(params[:micropost])
		@feed_items = []	
		if @micropost.save
			respond_to do |format|
		  		format.html { redirect_to root_path }
		  		format.js do
					if params[:src]=='home' 
						@feed_items = current_user.feed.paginate(page: params[:page])
					else
						flash[:success] = "Posted"
					end
		  		end
			end
		else
			
			render 'static_pages/home'
		end
	end

	def destroy
    	@micropost.destroy
    	redirect_to root_path
  	end

	private
		def correct_user
  			@micropost = current_user.microposts.find(params[:id])
			rescue
  				redirect_to root_path
		end
	  	
end
