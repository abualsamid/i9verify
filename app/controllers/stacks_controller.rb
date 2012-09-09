class StacksController < ApplicationController
	before_filter :signed_in_user
	before_filter :correct_user, only: [:destroy]
	before_filter :prep_stacks, only: [:index, :show, :destroy]

	def index
		@stack = current_user.stacks.first
		if @stack then
			@task = @stack.tasks.build
			@tasks = @stack.tasks.where("status_id <> ?",1000).paginate(page: params[:page])
		end
	
	end


	def show
		
		@stack = current_user.stacks.find params[:id]
		@micropost = current_user.microposts.build 

		if !@stack.nil? then
			@task = @stack.tasks.build
			@tasks = @stack.tasks
					.where("status_id <> ?",1000)
					.order("due desc, priority desc, status_id desc, updated_at desc")
					.paginate(page: params[:page])
		end
		
	end
		
	def new
		@newstack = Stack.new
	end

	def destroy
		begin
			if @stack.tasks.any? then
				flash.now[:error]="Failed to Delete Stack: #{@stack[:name]}: There are #{@stack.tasks.count} tasks in this Stack."
			else
				@stack.destroy
				flash.now[:success]="Stack #{@stack.name} deleted."
			
			end 
			
			respond_to do |format|
		  		format.html { redirect_to stacks_path }
		  		format.js do
		  			@stacks = current_user.stacks.paginate(page: params[:page])
				
		  		end
			end
			
		rescue Exception => exception
			flash.now[:error]="Failed to Delete Stack: #{@stack[:name]}: #{exception.message} "
			respond_to do |format|
		  		format.html { redirect_to stacks_path }
		  		format.js do
		  			@stacks = current_user.stacks.paginate(page: params[:page])
				
		  		end
			end
			
		end

	end 	

	def create
		begin  
			@stack = params[:stack]
			@n = current_user.stacks.new(@stack)
			if	@n.save
				flash[:success]="Stack #{@stack[:name]} created."
			
			else
				flash[:error]="Failed to Create Stack #{@stack[:name]}. Duplicate Stack Names are not allowed."
			end
			respond_to do |format|
		  		format.html { redirect_to stacks_path }
		  		format.js do
		  			@stacks = current_user.stacks.paginate(page: params[:page])
					@newstack = Stack.new
			
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
	
	private
		def prep_stacks
			@stacks = current_user.stacks.paginate page: params[:stacks_page]
			@newstack = Stack.new
			@user = current_user

		end
		
		def correct_user
			@stack = current_user.stacks.find(params[:id])
			rescue
  				redirect_to root_path
		end
	
end
