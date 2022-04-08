Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # //get "sign_up", to: "registrations#create"
  # post '/users/sign_up' => 'registrations#create'
  post '/account/add_calories' => 'account#add_calories'
  post '/users/sign_up' => 'user#create'
  post '/account/sign_in' => 'user#login'


  get '/users/show_all_users' => 'registrations#index'
  post '/account/logout' => 'sessions#delete'
  post '/checkauth' => 'account#auth'


  post '/account/subtract_calories' => 'account#subtract_calories'



  post '/admin/show' => 'admin#show'
  post '/show_all_food_desc' => 'account#show_all_food_desc'
  post '/show_all_food_asc' => 'account#show_all_food_asc'
  post '/show_all_food' => 'account#show_all_food'
  post '/show_one_food' => 'account#show_one_food'



  post '/admin/add_food_item' => 'admin#add_food_item'
  post '/admin/add_image_to_item' => 'admin#add_image_to_item'









end
