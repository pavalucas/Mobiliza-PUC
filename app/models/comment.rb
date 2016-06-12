class Comment < ActiveRecord::Base
	belongs_to :commenter, :polymorphic => true

	validates :commenter_id, presence: true
	validates :commenter_type, presence: true

end
