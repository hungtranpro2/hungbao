class UserProject < ApplicationRecord
	enum role: {member: 0, leader: 1}
  belongs_to :user
  belongs_to :project
  validates_uniqueness_of :user_id, scope: :project_id
end
