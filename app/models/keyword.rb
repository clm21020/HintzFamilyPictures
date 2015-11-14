# == Schema Information
#
# Table name: keywords
#
#  id         :integer          not null, primary key
#  item_id    :string           not null
#  word       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Keyword < ActiveRecord::Base
	validates :word, :item_id, presence: true

	belongs_to :item
end
