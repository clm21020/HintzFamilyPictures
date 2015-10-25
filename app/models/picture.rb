# == Schema Information
#
# Table name: pictures
#
#  id         :integer          not null, primary key
#  url        :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  item_id    :integer          not null
#

class Picture < ActiveRecord::Base
	validates :url, presence: true
end
