# == Schema Information
#
# Table name: pictures
#
#  id                 :integer          not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  item_id            :integer          not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class Picture < ActiveRecord::Base
	belongs_to :item

	has_attached_file :image, {
		small: "80x80",
		medium: "200x200"
	}
	validates_attachment :image, {
		presence: true, 
		content_type: { content_type: /\Aimage/ }
	}
end
