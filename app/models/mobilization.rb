class Mobilization < ActiveRecord::Base
	belongs_to :user
	has_and_belongs_to_many :targets
	validates :user_id, presence: true
	acts_as_voteable
end
