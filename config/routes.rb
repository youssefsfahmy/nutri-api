Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # //get "sign_up", to: "registrations#create"
  post '/users/sign_up' => 'registrations#create'
  post '/account/add_calories' => 'account#add_calories'


  get '/users/show_all_users' => 'registrations#index'
  post '/account/sign_in' => 'sessions#create'
  post '/account/logout' => 'sessions#delete'

  post '/account/subtract_calories' => 'account#subtract_calories'



  post '/admin/show' => 'admin#show'
  post '/admin/add_food_item' => 'admin#add_food_item'
  post '/admin/add_image_to_item' => 'admin#add_image_to_item'









end
