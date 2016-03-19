class User < ActiveRecord::Base
	attr_accessor :session_token

	before_save { self.email = email.downcase }
	validates :email, presence: true, uniqueness: {case_sensitive: false}
	validates :name, presence: true
	has_secure_password
	validates :password, presence: true

	def User.new_token
		SecureRandom.urlsafe_base64
	end

	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : 
																									BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	def remember
		self.session_token = User.new_token
		update_attribute(:session_digest, User.digest(self.session_token))
end
