class UsersController < ApplicationController
	include SessionHelper
	before_action :should_login
	def new
		@user ||= User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to admin_login_url and return
		end
		render new
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		redirect_to admin_login_url
	end

	private
		def user_params
			params.require(:user).permit(:email, :name, :password, :password_confirmation)
		end
end
