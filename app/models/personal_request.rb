class PersonalRequest < ApplicationRecord
  PARAMS = %i(user_id project_id title reason).freeze

  enum status: {waiting: 0, approval: 1, rejected: 2, forwarded: 3}

  belongs_to :user
  belongs_to :project, class_name: Project.name, foreign_key: :project_id
  has_many :notifications, as: :object
  has_many :approval_requests, dependent: :destroy

  validates :title, presence: true
  validates :reason, presence: true
end
