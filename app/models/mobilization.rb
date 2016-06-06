class Mobilization < ActiveRecord::Base
	belongs_to :user
	has_and_belongs_to_many :targets
	validates :user_id, presence: true
	acts_as_voteable
	validates :goal, presence: true, numericality: { only_integer: true, greater_than: 24 }
end
