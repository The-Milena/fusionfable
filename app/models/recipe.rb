class Recipe < ApplicationRecord
  belongs_to :recipe_request
  has_many :recipe_ingredients, dependent: :destroy
  has_many :detected_ingredients, through: :recipe_ingredients
  has_many :saved_recipes, dependent: :destroy
  has_many :users, through: :saved_recipes

  validates :name, presence: true, uniqueness: true
  validates :instructions, presence: true
  validates :recipe_request_id, presence: true
end
