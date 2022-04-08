class Food < ApplicationRecord
  has_one_attached :avatar
  
  validates :name, presence: true
  validates :calories, presence: true
  validates :serving, presence: true
end
