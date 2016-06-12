class User < ActiveRecord::Base
	has_many :mobilizations, dependent: :destroy
	has_many :comments, :as => :commenter

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	VALID_REGISTRARION_REGEX = /\d\d[1-2]\d+/
	validates :email, uniqueness: true, format:     { with: VALID_EMAIL_REGEX }
	validates :registration, uniqueness: true, length: { is: 7 }, format: {with: VALID_REGISTRARION_REGEX}
	acts_as_voter
	
	def self.from_omniauth(auth)
	    where(provider: auth[:provider], uid: auth.uid).first_or_initialize.tap do |user|
	      user.provider = auth.provider
	      user.uid = auth.uid
	      user.name = auth.info.name
	      user.oauth_token = auth.credentials.token
	      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
	      user.save!
	    end
  	end

end
