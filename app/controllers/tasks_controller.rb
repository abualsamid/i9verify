class TasksController < ApplicationController
	before_filter :signed_in_user

	def new
		@stack = current_user.stacks.find_by_name(params[:id])
		
		@task = @stack.tasks.build
	end
	
	def create
		begin  
			logger.debug params[:id]
			
			@stack = current_user.stacks.find_by_name(params[:stack_id])
			
			if @stack.nil? 
				flash.now[:error]="Failed to Create Task #{params[:task][:name]}. Could not load Stack: #{params[:id]} ."
			else
				@task = @stack.tasks.build(params[:task])
				@task.company_id=0			
				@task.user_id  = current_user.id
				if	@task.save
					flash.now[:success]="Task #{@task[:name]} created."
			
				else
					flash.now[:error]="Failed to Create Task #{params[:task][:name]}. Duplicate Task Names are not allowed."
				end
				respond_to do |format|
			  		format.html { redirect_to @stack }
			  		format.js do
			  			@tasks = @stack.tasks.paginate(page: params[:page])
				
			  		end
				end
			end 
			
			
    	rescue Exception => exception
	  		flash.now[:error]="Failed to Create Task: #{params[:task][:name]}: #{exception.message} "
			respond_to do |format|
		  		format.html { redirect_to current_user }
		  		format.js do
		  			@tasks = @stack.tasks.paginate(page: params[:page])
				
				
		  		end
			end
			
		end	
	end
	
end
