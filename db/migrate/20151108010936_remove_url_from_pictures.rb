class RemoveUrlFromPictures < ActiveRecord::Migration
  def change
  	remove_column :pictures, :url, :text
  end
end
