module SessionHelper
	def should_login
  	flash.alert = "Please log in."
  	redirect_to admin_login_url
  end
end
