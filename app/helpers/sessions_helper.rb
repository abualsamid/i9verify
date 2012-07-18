module SessionsHelper
	def sign_in(user)
		session[:remember_token]=user.id
    	self.current_user=user
	end
	
	def sign_out 
		session[:remember_token]=nil
		current_user=nil
		reset_session
	end 
	
	def signed_in?
		return false if session[:remember_token].nil?
    	!current_user.nil?
  	end
	
	def current_user=(user)
		@current_user = user
	end
	
	def current_user
		return nil if session.nil?
		return nil if session[:remember_token].nil?
    	@current_user ||= User.find(session[:remember_token])

  	end
  	
  	def current_user?(user)
  		return user==current_user
  	end
  	
  	def redirect_back_or(default)
    	redirect_to(session[:return_to] || default)
    	session.delete(:return_to)
  	end

  	def store_location
    	session[:return_to] = request.fullpath
  	end
end
