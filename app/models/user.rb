class User < ApplicationRecord
	attr_accessor :remember_token 
	before_create { self.save_token }
	require 'digest/sha1'
	has_many :posts

	validates :name, presence: true
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }

	def User.new_token
		token = SecureRandom.urlsafe_base64
		token.to_s
	end

	def digest(token)
		Digest::SHA1.hexdigest token
	end

	def save_token
		self.remember_token = digest(User.new_token)
	end

	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, digest(remember_token))
	end

	def forget
		update_attribute(:remember_digest, nil)
	end
end