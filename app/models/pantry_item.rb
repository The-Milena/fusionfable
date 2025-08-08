class PantryItem < ApplicationRecord
  belongs_to :recipe_request

  validates :name, presence: true, uniqueness: true
  validates :recipe_request_id, presence: true
end
