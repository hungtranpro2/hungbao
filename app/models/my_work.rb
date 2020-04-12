class MyWork < ApplicationRecord
  PARAMS = %i{user_id title start_time end_time description}

  belongs_to :user

  validates :title, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
end
