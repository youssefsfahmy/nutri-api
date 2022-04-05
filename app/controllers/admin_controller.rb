class AdminController  < ApplicationController 
    before_action :require_to_be_admin!

    def show
        render json:  Current.user.to_json
    end

    def add_food_item 
        fooditem = Fooditem.create!(food_params)
    end

    def add_image_to_item
        @fooditem = Fooditem.find_by(id: 2)
        p @fooditem
        # @fooditem.image.attach(params[:image])
        p @fooditem.image.attached?
    end


    private
    def food_params
      params.require(:fooditem).permit(:name, :picture, :calories, :serving)
    end
    def image_params
        params.require(:image)
        params.require(:id)
    end
end