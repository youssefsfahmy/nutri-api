class AdminController  < ApplicationController 
    before_action :authorized 

    def show
        render json:  Current.user.to_json
    end

    def add_food_item 

        p food_params
        @a = params[:avatar]
        
        @fooditem = Food.create!(food_params)
        @fooditem.avatar.attach(params[:avatar])
        p "---------------------------"

        p @fooditem.avatar
        # p fooditem
        # fooditem.picture.attach(params[:image])
    end



    def add_image_to_item
        @fooditem = Fooditem.find_by(id: 2)
        p @fooditem
        # @fooditem.image.attach(params[:image])
        p @fooditem.image.attached?
    end


    private
    def food_params
        hash = JSON.parse p params[:data]


        
        params.require(:avatar)
        params = ActionController::Parameters.new(hash)
        params.require(:fooditem).permit(:name, :picture, :calories, :serving)
    end
    def image_params
        params.require(:image)
        params.require(:id)
    end
end