class ApplicationController < ActionController::API
    before_action :authorized, only: [:auto_login]


    rescue_from ActiveRecord::RecordNotFound do |exception|
        json_response({ message: exception.message }, :not_found)
    end

    def set_current_user
        if session[:user_id]
            Current.user = User.find_by(id: session[:user_id])
            if Current.user.dateremaining !=  Date.today               
                Current.user.update_attribute(:remainingcalories, Current.user[:caloriesperday]) && Current.user.update_attribute(:dateremaining,  Date.today) 
            end           
        end 
    end


    # def require_user_logged_in!
    #     render json: {message: "You must be signed in", statusCode: 404}, status: :unprocessable_entity if Current.user.nil? 
    # end
    
    # def check_user_logged_in!
    #     p Current.user
    #     if Current.user.nil? 
    #         render json: {message: "You must be signed in", statusCode: 404}, status: 401
    #     else
    #         render json:  {statusCode:  Current.user ,message: "Authorized" } 
    #     end

    # end

    def require_to_be_admin!
        p Current.user[:admin] == false
        render json: {message: "Access denied, admin autherization only", statusCode: 500}, status: :unprocessable_entity if  Current.user[:admin] == false 
    end

      def encode_token(payload)
        JWT.encode(payload, 'yourSecret')
      end
    
      def auth_header
        # { Authorization: 'Bearer <token>' }
        request.headers['Authorization']
      end
    
      def decoded_token
        if auth_header
          token = auth_header.split(' ')[1]
          # header: { 'Authorization': 'Bearer <token>' }
          begin
            JWT.decode(token, 'yourSecret', true, algorithm: 'HS256')
          rescue JWT::DecodeError
            nil
          end
        end
      end
    
      def logged_in_user
        if decoded_token
          user_id = decoded_token[0]['user_id']   
          @user = User.find_by(id: user_id) 
          session[:user_id]= @user.id
          set_current_user
          @user
       
        end
      end
    
      def logged_in?
        !!logged_in_user
      end
    
      def authorized
        render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
      end

    
end
