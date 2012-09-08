class UsersController < ApplicationController
	before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :following , :followers ]
	before_filter :correct_user,   only: [:edit, :update], not: [:destroy]
	before_filter :admin_user, only: [:destroy]  
  
  def new
  	@user = User.new
  end
  
  def show
  	@user = User.find(params[:id])
  	@microposts = @user.microposts.paginate(page: params[:page])
  	@micropost = Micropost.new
  	@stacks = @user.stacks.paginate(page: params[:stack_page])
  end 
  
  def edit
  	@user = User.find(params[:id])
  end

	def following
	    @title = "Following"
	    @user = User.find(params[:id])
	    @users = @user.followed_users.paginate(page: params[:page])
	    render 'show_follow'
	end

  	def followers
    	@title = "Followers"
    	@user = User.find(params[:id])
    	@users = @user.followers.paginate(page: params[:page])
    	render 'show_follow'
  	end
  
  def update
  	@user = User.find(params[:id])
  	if @user 
  		if @user.update_attributes params[:user]
  			flash.now[:success] = "Profile Updated Successfully."
  			sign_in @user # to update security/session tokens and expire hijacked sessions when a user updates their profile.
  			redirect_to @user
  		else
  			render 'edit'
  		end
  	else
  		render 'edit' 
  	end
  	
  end
  
  def destroy
  	if current_user.admin?
  		@user = User.find(params[:id])
  		@user.delete
  		flash[:success] = "User #{@user.name} deleted successfully."
  		redirect_to users_path
  	end
  end   
  
  def create
    @user = User.new(params[:user])
    if @user.save
      # Handle a successful save.
      sign_in @user
      flash[:success] = "#{@user.name}: Welcome to Perfect Trax!"
      redirect_to root_path
    else
      render 'new'
    end
  end
  
  def index 
  	@users = User.paginate(page: params[:page])
  	@user = current_user
  	@microposts = @user.microposts.paginate(page: params[:page])
  	@micropost = Micropost.new
  	@stacks = @user.stacks.paginate(page: params[:stack_page])

  end
  
  
  private
  
  	
    def correct_user 
    	tmp_user = User.find(params[:id])
    	return redirect_to root_path, notice: "You are not allowed to mess around with somebody else's profile!" if !tmp_user 
   		return redirect_to root_path, notice: "You are not allowed to mess around with somebody else's profile!" unless current_user==tmp_user
    end
    
    def admin_user
    	redirect_to root_path, notice: "The action you attempted is privileged." unless current_user.admin? 
    end 
end
