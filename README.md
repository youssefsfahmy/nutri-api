# README

This README documents whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
    ruby "3.1.1"
* System dependencies

* Configuration

* Database creation
    run $ rails db:migrate
* Database initialization
    run  $ rails c 
    $ User.create!(name: "admin", email: "admin@admin.com", password: "admin123", password_confirmation: "admin123", admin: true)
    OR use the API calls "http://localhost:3000/users/sign_up" in the Postman collection

    To add food use the API call in the postman "http://localhost:3000/admin/add_food_item" collection in order to add the image in the form


* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions
    $ rails s 

    To start the server on localhost:3000
* ...
