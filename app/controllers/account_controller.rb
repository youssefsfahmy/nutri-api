class AccountController  < ApplicationController        
    before_action :authorized

    def auth
        @user = logged_in_user()
        p "------------------"
        auth_header= auth_header()
         token = auth_header.split(' ')[1]
          render json: {user:@user, message: 'Success', token: token}, status: :created
   
   
      end

    def show
        render json:  Current.user.to_json
    end

    def show_all_food 
        food = Food.order("name ASC")
        render json: {food: food.to_json,  statusCode: 0, message: "Success"} , status: :created

    end

    def show_one_food 
        p"-----------------"

        p image_params
        p"-----------------"

        @food = Food.find_by(id:params[:id])
        p @food
        if(@food.avatar.attached?)
            @route = Rails.application.routes.url_helpers.rails_blob_path(@food.avatar, only_path: true)
        else
            @rout=""
        end
        render json: {food: @food.to_json,  statusCode: 0, message: "Success", route: @route} , status: :created

    end

    def show_all_food_desc

        food = Food.order("calories DESC")
        render json: {food: food.to_json,  statusCode: 0, message: "Success"} , status: :created
    end

    def show_all_food_asc
      food = Food.order("calories ASC")
      render json: {food: food.to_json,  statusCode: 0, message: "Success"} , status: :created
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

    end
    private

    def calories_params 
        permitted =params.require(:user).permit(:caloriesperday)
    end

    def subtract_params 
        permitted =params.require(:fooditem).permit(:calories)
    end

    def image_params 
        permitted =params.require(:id)
    end
end