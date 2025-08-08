class CreateRecipeIngredients < ActiveRecord::Migration[7.1]
  def change
    create_table :recipe_ingredients do |t|
      t.references :detected_ingredient, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true
      t.float :quantity

      t.timestamps
    end
  end
end
