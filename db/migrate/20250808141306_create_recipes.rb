class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.string :title
      t.text :instructions
      t.time :preparation_time
      t.string :cuisine_type
      t.references :recipe_request, null: false, foreign_key: true

      t.timestamps
    end
  end
end
