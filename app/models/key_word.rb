# == Schema Information
#
# Table name: key_words
#
#  id         :integer          not null, primary key
#  item_id    :string           not null
#  word       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class KeyWord < ActiveRecord::Base
	validates :word, :item_id, presence: true

	belongs_to :item
end
