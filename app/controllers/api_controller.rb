require 'jwt'
require 'bcrypt'


class ApiController < ApplicationController

  def index
  	if params[:token]==nil
  		message={success: false, message: "No token provided!"}
  		render :json => message
  		return
  	end

  	begin
  		decoded_token = JWT.decode(params[:token], Rails.application.secrets.jwt_key, true, { :algorithm => 'HS256' })

  		user=User.find_by(username: decoded_token[0]["username"])
  		if user==nil
  			message={success: false, message: "Wrong credentials!"}
	  		render :json => message
	  		return
	  	else

	  		if BCrypt::Password.new(user.password)==decoded_token[0]["password"]

		  		message={success: true, message: "Valid token!"}
		  		render :json => message
		  		return

		  	else

		  		message={success: false, message: "Wrong credentials!"}
		  		render :json => message
		  		return

		  	end
  		end


	rescue JWT::ExpiredSignature
  		message={success: false, message: "The token provided is expired!"}
  		render :json => messag
	end

  end

  def signup
  	if params[:username]==nil
  		message={success: false, message: "No username provided!"}
  		render :json => message
  		return
  	end
  	if params[:password]==nil
  		message={success: false, message: "No password provided!"}
  		render :json => message
  		return
  	end
  	if params[:email]==nil
  		message={success: false, message: "No email provided!"}
  		render :json => message
  		return
  	end

  	password_hash=BCrypt::Password.create(params[:password])

  	user=User.new(username: params[:username], password: password_hash, email: params[:email])

  	if user.valid?
  		user.save
  		message={success: true, message: "Account created!"}
  		render :json => message
  	else
  		if user.errors.messages[:username]!=nil
  			error_message=user.errors.messages[:username][0]
  		elsif user.errors.messages[:password]!=nil
  			error_message=user.errors.messages[:password][0]
  		else
  			error_message=user.errors.messages[:email][0]
  		end
  		message={success: false, message: error_message}
  		render :json => message
  	end

  end
end
