class Report < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_many :notifications, as: :object
end
