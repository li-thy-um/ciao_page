class User < ActiveRecord::Base
	attr_accessor :session_token
	before_save { self.email = email.downcase }
	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, 
										length: { maximum: 255 },
										uniqueness: { case_sensitive: false },
										format: { with: EMAIL_REGEX }
	validates :name, presence: true,
									 length: { maximum: 50 }
	has_secure_password
	validates :password, presence: true,
											 length: { minimum: 6 }
	validates :password_confirmation, presence: true

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

	def forget
		update_attribute(:session_digest, nil)
	end

	def authenticate_token(token)
		BCrypt::Password.new(self.session_digest).is_password?(token)		
	end
end
