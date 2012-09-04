class TasksController < ApplicationController
	before_filter :signed_in_user
	before_filter :correct_user,   only: [:destroy ]
	before_filter :correct_user_by_stack_name, only: [:update]

	def new
		@stack = current_user.stacks.find_by_name(params[:id])
		
		@task = @stack.tasks.build
	end
	
	def destroy
	
		@task.destroy		
		respond_to do |format|
			format.html {redirect_to @stack}
			format.js do
				@tasks = @stack.tasks.paginate(page: params[:page])
			end				
		end
	end
	
	def update 
		@task.update_attributes(params[:task])
		if @task.save 
			flash.now[:success]="Task #{@task.name} updated."
		else
			flash.now[:error]="Failed to Update Task."
		end if
		respond_to do |format|
			format.html {redirect_to @stack}
			format.js do
				@tasks = @stack.tasks.paginate(page: params[:page])
			end
		end
	end
	
	def show
	end
	
	def create
		begin  
			
			@stack = current_user.stacks.find_by_name(params[:stack_id])
			
			if @stack.nil? 
				flash.now[:error]="Failed to Create Task #{params[:task][:name]}. Could not load Stack: #{params[:id]} ."
			else
				@task = @stack.tasks.build(params[:task])
				@task.company_id=0			
				@task.user_id  = current_user.id
				if	@task.save
					flash.now[:success]="Task #{@task.name} created."
			
				else
					flash.now[:error]="Failed to Create Task #{params[:task][:name]}. Duplicate Task Names are not allowed."
				end
				respond_to do |format|
			  		format.html { redirect_to @stack }
			  		format.js do
			  			@tasks = @stack.tasks.page(params[:page])
				
			  		end
				end
			end 
			
			
    	rescue Exception => exception
	  		flash.now[:error]="Failed to Create Task: #{params[:task][:name]}: #{exception.message} "
			respond_to do |format|
		  		format.html { redirect_to current_user }
		  		format.js do
		  			@tasks = @stack.tasks.page(params[:page])
				
				
		  		end
			end
			
		end	
	end
	
	private
		def correct_user
			@stack = current_user.stacks.find(params[:stack_id])
			@task = @stack.tasks.find(params[:id])
			rescue
  				redirect_to root_path
		end
		
		def correct_user_by_stack_name
			@stack = current_user.stacks.find_by_name(params[:stack_id])
			@task = @stack.tasks.find(params[:id])
			rescue
  				redirect_to root_path
		end
		
	  	
end