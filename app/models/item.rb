# == Schema Information
#
# Table name: items
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Item < ActiveRecord::Base
	validates :title, presence: true

	has_many :pictures
	has_many :keywords

	has_many :rankings
	has_many :interested_rankings, -> { where "interest_level > 0" }, class_name: "Ranking"
	has_many :disinterested_rankings, -> { where "interest_level < 0" }, class_name: "Ranking"

	has_many :rankers, through: :rankings, source: :user
	has_many :interested_rankers, through: :interested_rankings, source: :user
	has_many :disinterested_rankers, through: :disinterested_rankings, source: :user
end
