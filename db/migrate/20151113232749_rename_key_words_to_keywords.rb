class RenameKeyWordsToKeywords < ActiveRecord::Migration
  def change
  	rename_table :key_words, :keywords
  end
end
