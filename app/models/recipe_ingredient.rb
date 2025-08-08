class RecipeIngredient < ApplicationRecord
  belongs_to :detected_ingredient
  belongs_to :recipe

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :detected_ingredient_id, presence: true
  validates :recipe_id, presence: true
end
