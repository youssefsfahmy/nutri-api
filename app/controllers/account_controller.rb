class AccountController  < ApplicationController        
    before_action :require_user_logged_in!



    def show
        render json:  Current.user.to_json
    end

    def add_calories
        begin
            calories_params
        rescue => error
            render json: {message: error, statusCode: 400}, status: :unprocessable_entity, statusCode: 1
            return
        end
  
        if @user = Current.user.update_attribute(:caloriesperday, params[:user][:caloriesperday])  && Current.user.update_attribute(:remainingcalories, params[:user][:caloriesperday]) && Current.user.update_attribute(:dateremaining,  Date.today) 
            Date.today
            Current.user = User.find_by(id: session[:user_id])

            render json: {user: Current.user,  statusCode: 0, message: "Success"} , status: :created
        else
            render json:  {statusCode: 401 ,message: "Something went wrong" } 
        end
    end

    def subtract_calories
        begin
            subtract_params
        rescue => error
            render json: {message: error, statusCode: 400}, status: :unprocessable_entity, statusCode: 1
            return
        end
        
        @remaining = Current.user.remainingcalories - params[:fooditem][:calories]

       
        p @remaining

        if @remaining < 0
            render json:  {statusCode: 405 ,message: "Calories exceed the remaining calories" } 
        else
            Current.user.update_attribute(:remainingcalories, @remaining)
            render json: {user: Current.user,  statusCode: 0, message: "Success"} , status: :created
        end

        # if @user = Current.user.update_attribute(:caloriesperday, params[:user][:caloriesperday])  && Current.user.update_attribute(:remainingcalories, params[:user][:caloriesperday]) && Current.user.update_attribute(:dateremaining,  Date.today) 
        #     Date.today
        #     Current.user = User.find_by(id: session[:user_id])

        #     render json: {user: Current.user,  statusCode: 0, message: "Success"} , status: :created
        # else
        #     render json:  {statusCode: 401 ,message: "Something went wrong" } 
        # end
    end
    private

    def calories_params 
        permitted =params.require(:user).permit(:caloriesperday)
    end

    def subtract_params 
        permitted =params.require(:fooditem).permit(:calories)
    end
end