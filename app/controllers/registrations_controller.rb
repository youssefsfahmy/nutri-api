class RegistrationsController  < ApplicationController

    
    def index
        user = User.all
        render json: user.to_json
    end

    def show
        user = User.find_by(id: params[:id])
        render json: user.to_json
    end


    def create
        begin
        @user = User.new(user_params)
        rescue => error

            render json: {message: error, statusCode: 400}
            return
        end

        if User.find_by(email: @user.email) 
            render json: {message: "Email already exists", statusCode: 402}
            return
        end
        if @user.save
            session[:user_id]= @user.id
            render json: {user: @user,  statusCode: 0, message: "Success"} 
        else
            render json:  {statusCode: 401 ,message:@user.errors.first.message }
        
    end
    end






    private
    
    def user_params
        
        params.require(:user).permit(:email, :password, :password_confirmation, :admin)
        # params.require(:user).require(:email)
        # params.require(:user).require(:password)
        # params.require(:user).require(:password_confirmation)
        # params.require(:user).require(:admin)
    end

    def calories_params
        
        permitted =params.require(:user).permit(:caloriesperday)

    end
end