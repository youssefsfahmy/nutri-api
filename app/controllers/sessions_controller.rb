class SessionsController  < ApplicationController 
    def new 
    end
    
    def create
        begin
            @user = user_params
        rescue => error
            render json: {message: error, statusCode: 400}
            return
        end

        @user = User.find_by(email: params[:user][:email])
        if @user.present? 
            if  @user.authenticate(params[:user][:password])

                session[:user_id]= @user.id
                set_current_user
                render json: {user: Current.user,  statusCode: 0, message: "Success"} 
            else
                render json:  {statusCode: 401 ,message:"Email or Password is incorrect " }
            end
        else
            render json:  {statusCode: 401 ,message: "Email or Password is incorrect" }

        end
    end

    
    
    def delete
        session[:user_id] = nil
        render json:  {statusCode: 0 ,message: "Successfully logged out" } 
    end
00
    private
    
    def user_params
        params.require(:user).permit(:email, :password)
        params.require(:user).require(:email)
        params.require(:user).require(:password)

    end


end