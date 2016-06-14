class Mobilization < ActiveRecord::Base
	belongs_to :user
	has_and_belongs_to_many :targets
	has_many :comments
	validates :user_id, presence: true
	acts_as_voteable
	paginates_per 9
	validates :title, uniqueness: true
	validates :goal, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 25 }
	validates :status, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 4 }
end
