class PersonalRequest < ApplicationRecord
  PARAMS = %i(request_type time_from time_to reason).freeze

  enum status: {waiting: 0, approval: 1, rejected: 2, forwarded: 3}
  enum request_type: {lated: 0, leaved: 1}

  belongs_to :user
  has_many :notifications, as: :object
  has_many :approval_requests, dependent: :destroy

  validates :time_from, presence: true
  validates :time_to, presence: true
end
