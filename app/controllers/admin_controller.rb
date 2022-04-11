class AdminController  < ApplicationController 
    before_action :authorized_admin

    def show
        render json:  Current.user.to_json
    end

    def add_food_item 
        begin
        
        @a = params[:avatar]
        
        @fooditem = Food.create!(food_params)
        @fooditem.avatar.attach(params[:avatar])
        render json: {message: "successfully added", statusCode: 0}

    rescue => error
        render json: {message: error, statusCode: 400}
            return
        end

        # fooditem.picture.attach(params[:image])
    end





    private
    def food_params
        hash = JSON.parse  params[:data]

        params.require(:avatar)
        params = ActionController::Parameters.new(hash)
        params.require(:fooditem).permit(:name, :picture, :calories, :serving)
    end
    def image_params
        params.require(:image)
        params.require(:id)
    end
end