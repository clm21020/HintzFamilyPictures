# == Schema Information
#
# Table name: rankings
#
#  id             :integer          not null, primary key
#  user_id        :integer          not null
#  item_id        :integer          not null
#  interest_level :integer          not null
#

class Ranking < ActiveRecord::Base
	validates :user_id, :item_id, :interest_level, presence: true

	belongs_to :user
	belongs_to :item
end
