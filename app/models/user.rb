class User < ActiveRecord::Base
	validates :username, presence: { message: "Username is required!" }
	validates :password, presence: { message: "Password is required!" }
	validates :email, presence: { message: "Email is required!" }

	validates :username, length: { minimum: 5, message: "Username has to be between 5 and 20 characters!" }
	validates :username, length: { maximum: 5, message: "Username has to be between 5 and 20 characters!" }

	validates :username, uniqueness: { message: "Username already taken!" }
end
