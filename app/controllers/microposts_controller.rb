class MicropostsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user,   only: :destroy

	def create
		@micropost = current_user.microposts.build(params[:micropost])
		if !params[:task_id].nil? && !params[:stack_id].nil?
			@s = Stack.find params[:stack_id]
			@t = @s.tasks.find params[:task_id]
			if !@t.nil?
				@micropost.task_id = @t.id
			end
			
		end
		@feed_items = []	
		if @micropost.save
			respond_to do |format|
		  		format.html { redirect_to root_path }
		  		format.js do
		  			case params[:src]
		  				when 'home'
		  					@feed_items = current_user.feed.paginate(page: params[:page])
		  				when 'edit_task'
		  					@feed_items = @t.microposts.page(params[:feed_page])
		  				else
		  					flash[:success] = "Posted"
		  			end
					render partial: 'shared/inlinefeed.js'
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
