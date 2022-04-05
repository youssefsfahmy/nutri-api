class ApplicationController < ActionController::API
    before_action :set_current_user

    rescue_from ActiveRecord::RecordNotFound do |exception|
        json_response({ message: exception.message }, :not_found)
    end

    def set_current_user
        if session[:user_id]
            Current.user = User.find_by(id: session[:user_id])
            p "AHOOOOO"
            if Current.user.dateremaining !=  Date.today               
                Current.user.update_attribute(:remainingcalories, Current.user[:caloriesperday]) && Current.user.update_attribute(:dateremaining,  Date.today) 
            end           
        end 
    end


    def require_user_logged_in!
        render json: {message: "You must be signed in", statusCode: 404}, status: :unprocessable_entity if Current.user.nil? 
    end

    def require_to_be_admin!
        p Current.user[:admin] == false
        render json: {message: "Access denied, admin autherization only", statusCode: 500}, status: :unprocessable_entity if  Current.user[:admin] == false 
    end
end
