module SessionHelper
	def should_login
		return if logged_in?
  	flash.alert = "Please log in."
  	redirect_to users_login_url
  end

  def log_in(user)
  	user.remember
  	cookies.permanent.signed[:user_id] = user.id
  	cookies.permanent[:session_token] = user.session_token
  end

  def log_out(user)
  	user.forget
  	@current_user = nil
  	cookies.delete(:user_id)
  	cookies.delete(:session_token)
  end

  def current_user
  	if (user_id = cookies.signed[:user_id])
  		user = User.find_by(id: user_id)
  		if user && user.authenticate_token(cookies[:session_token])
  			@current_user = user
  		end
  	end
  end

  def logged_in?
  	!current_user.nil?
  end
end
