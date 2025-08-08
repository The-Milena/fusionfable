class CreatePantryItems < ActiveRecord::Migration[7.1]
  def change
    create_table :pantry_items do |t|
      t.string :name
      t.references :recipe_request, null: false, foreign_key: true

      t.timestamps
    end
  end
end
