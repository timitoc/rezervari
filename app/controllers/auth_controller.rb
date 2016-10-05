require 'jwt'
require 'bcrypt'

class AuthController < ApplicationController
  def get
  	message={ success: true }
  	render :json => message
  end
  def post
  	if params[:username]==nil
  		message={ success: false, message: "No username provided!"}
  		render :json => message
  		return
  	end
  	if params[:password]==nil
  		message={ success: false, message: "No password provided!"}
  		render :json => message
  		return
  	end
  	username=params[:username]
  	password=params[:password]

  	user=User.find_by(username: username)

  	if user==nil
  		message={ success: false, message: "User not found!"}
  		render :json => message
  	else
  		password_hash=BCrypt::Password.new(user.password)
  		if password_hash==password

  			exp = Time.now.to_i + 24 * 3600

  			payload = {:username => username, :password => password, :exp => exp }
  			token = JWT.encode(payload,Rails.application.secrets.jwt_key,'HS256')
  			
  			message={ success: true, message: "ok", token: token}
  		else
  			message={ success: false, message: "Wrong password!"}
  		end

  		render :json => message
  	end


  end
end
