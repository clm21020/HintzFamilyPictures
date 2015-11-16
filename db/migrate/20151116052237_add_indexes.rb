class AddIndexes < ActiveRecord::Migration
  def change
  	add_index :keywords, :item_id
  	add_index :pictures, :item_id
  end
end
