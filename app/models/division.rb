class Division < ApplicationRecord

  has_many :users, dependent: :destroy
  has_many :approval_requests, dependent: :destroy
  has_many :reports, through: :users
  has_many :projects, through: :users
  has_many :tasks, through: :users
  has_many :project_requests, dependent: :destroy
end
