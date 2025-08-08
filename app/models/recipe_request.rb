class RecipeRequest < ApplicationRecord
  belongs_to :user
  has_many :pantry_items, dependent: :destroy
  has_many :detected_ingredients, dependent: :destroy
  has_many :recipes

  validates :photo_url, presence: true
  validates :user_id, presence: true
end
