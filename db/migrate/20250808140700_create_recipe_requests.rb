class CreateRecipeRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :recipe_requests do |t|
      t.string :photo_url
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
