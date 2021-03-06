class Target < ActiveRecord::Base
	has_and_belongs_to_many :targets, dependent: :destroy
	has_many :comments, :as => :commenter
	validates :name, presence: true
	validates :role, presence: true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  	validates :email, presence: true, uniqueness: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }

end
