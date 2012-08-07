class StacksController < ApplicationController
	before_filter :signed_in_user

	def index
		@stacks = current_user.stacks.paginate(page: params[:page])
		@stack = Stack.new
		@user = current_user
	end
	
	def new
	end
	
	def create
		begin  
			@stack = params[:stack]
			@n = current_user.stacks.new(@stack)
			if	@n.save
				flash.now[:success]="Stack #{@stack[:name]} created."
			
			else
				flash.now[:error]="Failed to Create Stack #{@stack[:name]}. Duplicate Stack Names are not allowed."
			end
			respond_to do |format|
		  		format.html { redirect_to stacks_path }
		  		format.js do
		  			@stacks = current_user.stacks.paginate(page: params[:page])
				
		  		end
			end
			
    	rescue Exception => exception
	  		flash.now[:error]="Failed to Create Stack: #{@stack[:name]}: #{exception.message} "
			respond_to do |format|
		  		format.html { redirect_to stacks_path }
		  		format.js do
		  			@stacks = current_user.stacks.paginate(page: params[:page])
				
		  		end
			end
			
		end	
	end
	
	def show
		@stack = current_user.stacks.find_by_name(params[:id])
		@task = @stack.tasks.build
		@tasks = @stack.tasks.paginate(page: params[:page])
	end
end
