class CreateKeyWords < ActiveRecord::Migration
  def change
    create_table :key_words do |t|
    	t.string :item_id, null: false
    	t.string :word, null: false

    	t.timestamps null: false
    end
  end
end
