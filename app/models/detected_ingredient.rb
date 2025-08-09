class DetectedIngredient < ApplicationRecord
  belongs_to :recipe_request
  has_many :recipe_ingredients, dependent: :destroy
  has_many :recipes, through: :recipe_ingredients

  validates :name, presence: true, uniqueness: true
  validates :recipe_request_id, presence: true
end
