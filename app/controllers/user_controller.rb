class UserController < ApplicationController
    before_action :authorized, only: [:auto_login]
  
    # REGISTER
    def create
      if User.find_by(email: params[:user][:email]) 
        render json: {message: "Email already exists", statusCode: 402}
        return
    end
      @user = User.create(user_params)
      if @user.valid?
        token = encode_token({user_id: @user.id})
        render json: {user: @user, token: token, statusCode: 0}
      else
        render json: {error: @user.errors.first.message}
      end
    end
  
    # LOGGING IN
    def login
      @user = User.find_by(email: params[:user][:email])
  
      if @user && @user.authenticate(params[:user][:password])
        token = encode_token({user_id: @user.id, admin: @user.admin})
        render json: {user: @user, token: token}
      else
        render json: {error: "Invalid username or password"}
      end
    end
  
  
    def auto_login
      render json: @user
    end
  
    private
  
    def user_params
        
        params.require(:user).permit(:email, :password, :password_confirmation, :admin)
   
    end
  
  end