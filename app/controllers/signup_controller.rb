class SignupController < ApplicationController
  def post
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
