class Fooditem < ApplicationRecord
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end



  validates :name, presence: true
  validates :calories, presence: true
  validates :serving, presence: true
  # validates :image, presence: true

end
