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
end
