module SessionHelper
	def should_login
  	flash.alert = "Please log in."
  	redirect_to admin_login_url
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
  		if user && user.authenicate_token(cookies.signed[:session_token])
  			log_in user
  			@current_user = user
  		end
  	end
  end

  def logged_in?
  	current_user.nil?
  end
end
