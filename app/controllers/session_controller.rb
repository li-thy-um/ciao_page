class SessionController < ApplicationController
	include SessionHelper
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  		log_in user
  		redirect_to root_url
  	else
  		flash.alert = 'invalid email/password combination'
  		render new
  	end
  end

  def destroy
  	log_out current_user
  	redirect_to root_url
  end
end
