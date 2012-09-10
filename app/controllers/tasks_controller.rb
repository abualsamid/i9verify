class TasksController < ApplicationController
	before_filter :signed_in_user
	before_filter :correct_user,   only: [:destroy ]
	before_filter :correct_user_by_stack_name, only: [:update, :edit]

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
		redirect_to edit_stack_task_path(@stack,@task) unless params[:cancel].blank?
		@task.update_attributes(params[:task])
		if @task.save 
			flash[:success]="Task #{@task.name} updated."
		else
			flash[:error]="Failed to Update Task."
		end if
		respond_to do |format|
			format.html {redirect_to edit_stack_task_path(@stack,@task) }
			format.js do
				@tasks = @stack.tasks.where("status_id <> ?",1000).paginate(page: params[:page])
			end
		end
	end
	
	def show
	end
	def edit 
		@micropost = current_user.microposts.build 
		@newstack = current_user.stacks.build
		@stacks = current_user.stacks.paginate page: params[:stacks_page]
		@user = current_user
		@feed_items = @task.microposts.page params[:feed_page]
	end
	
	def create
		begin  
			
			@stack = current_user.stacks.find(params[:stack_id])
			
			if @stack.nil? 
				flash.now[:error]="Failed to Create Task #{params[:task][:name]}. Could not load Stack: #{params[:stack_id]} ."
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
			@stack = current_user.stacks.find(params[:stack_id])
			@task = @stack.tasks.find(params[:id])
			rescue
  				redirect_to root_path
		end
		
	  	
end
