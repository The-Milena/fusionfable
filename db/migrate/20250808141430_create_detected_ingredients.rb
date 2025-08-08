class CreateDetectedIngredients < ActiveRecord::Migration[7.1]
  def change
    create_table :detected_ingredients do |t|
      t.string :name
      t.boolean :is_custom
      t.references :recipe_request, null: false, foreign_key: true

      t.timestamps
    end
  end
end
