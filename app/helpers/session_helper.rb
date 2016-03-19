module SessionHelper
	def should_login
  	flash.alert = "Please log in."
  	redirect_to admin_login_url
  end

  def login(user)
  	session[:user_id] = user.id
  end

  def current_user
  	@current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
  	current_user.nil?
  end
end
