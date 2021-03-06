# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  admin           :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
	validates :username, :email, :session_token, presence: true
	validates :username, :email, :session_token, uniqueness: true
	validates :password_digest, presence: { message: "Password can't be blank" }
	validates :password, length: { minimum: 6, allow_nil: true } 

	has_many :rankings
	has_many :interested_rankings, -> { where "interest_level > 0" }, class_name: "Ranking"
	has_many :disinterested_rankings, -> { where "interest_level < 0" }, class_name: "Ranking"

	has_many :interests, through: :interested_rankings, source: :item
	has_many :disinterests, through: :disinterested_rankings, source: :item

	attr_reader :password

	after_initialize :ensure_session_token

	def self.find_by_credentials(identifier, password)
		user = User.find_by_username(identifier) || User.find_by_email(identifier)
		return nil unless user && user.valid_password?(password)
		user
	end

	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end

	def valid_password?(password)
		BCrypt::Password.new(self.password_digest).is_password?(password)
	end

	def reset_session_token!
		self.session_token = SecureRandom::urlsafe_base64
		self.save!
		self.session_token
	end

	private
	def ensure_session_token
		self.session_token ||= SecureRandom::urlsafe_base64
	end
end
