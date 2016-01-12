class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
    	t.integer :user_id, null: false
    	t.integer :item_id, null: false
    	t.integer :interest_level, null: false
    end

    add_index :rankings, :user_id
    add_index :rankings, :item_id
  end
end
