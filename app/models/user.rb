
#email:string
#password_digest:string
#
#password:string virtual
#password_confirmation: string virtual
#virtua
class User < ApplicationRecord
    has_secure_password
    validates :email, presence: true, format: {with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, message: "Email must be a valid email address"}
    validates :password, :format => {:with => /\A(?=.*[a-zA-Z])(?=.*[0-9]).{6,}\z/    , message: "Password must be at least 6 characters and include one number and one letter."}
    validates :admin, inclusion: { in: [ true, false ] }
    # validates :caloriesperday, presence: true
end
