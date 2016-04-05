class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end

class User < ActiveRecord::Base
	attr_accessor :session_token
	before_save { self.email = email.downcase }
	validates :email, presence: true, 
										length: { maximum: 255 },
										uniqueness: { case_sensitive: false },
										email: true
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
