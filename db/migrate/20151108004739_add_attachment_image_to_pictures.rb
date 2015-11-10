class AddAttachmentImageToPictures < ActiveRecord::Migration
  def change
    add_attachment :pictures, :image
  end
end
