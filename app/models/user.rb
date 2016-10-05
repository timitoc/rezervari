class User < ActiveRecord::Base
	validates :username, presence: { message: "Username is required!" }
	validates :password, presence: { message: "Password is required!" }
	validates :email, presence: { message: "Email is required!" }

	validates :username, length: { minimum: 5, message: "Username has to be minimum 5 characters long!" }
	validates :username, length: { maximum: 20, message: "Username has to be maximum 20 characters long!" }

	validates :email, email: { message: "Invalid email address!"}

	validates :username, uniqueness: { message: "Username already taken!" }
end
