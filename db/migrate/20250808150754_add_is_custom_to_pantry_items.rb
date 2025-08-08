class AddIsCustomToPantryItems < ActiveRecord::Migration[7.1]
  def change
    add_column :pantry_items, :is_custom, :boolean
  end
end
