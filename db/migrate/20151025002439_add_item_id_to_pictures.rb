class AddItemIdToPictures < ActiveRecord::Migration
  def change
  	add_column :pictures, :item_id, :integer, { null: false }
  end
end
