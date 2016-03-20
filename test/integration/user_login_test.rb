class UserLoginTest < ActionDispatch::IntegrationTest
	include SessionHelper

	def setup
		@user = users(:one)
	end

	test 'login with valid information and followed by logout' do
		get admin_login_path
=begin
		post admin_login_path, session: {email: @user.email, passowrd: 'password'}
		assert_redirect_to root_path
		follow_redirect!
		assert_response :success
=end
	end
end