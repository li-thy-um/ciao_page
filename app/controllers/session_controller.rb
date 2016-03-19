class SessionController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  		login user
  		redirect_to root_url
  	else
  		flash.alert = 'invalid email/password combination'
  		render new
  	end
  end

  def destroy
  end
end
