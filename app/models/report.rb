class Report < ApplicationRecord
  PARAMS = %i(title plan actual next_plan issue project_id).freeze
  belongs_to :user
  belongs_to :project, class_name: Project.name, foreign_key: :project_id
  has_many :notifications, as: :object

  validates :title, presence: true, length: {maximum: 255}
  validates :plan, presence: true
  validates :actual, presence: true
  validates :next_plan, presence: true
  validates :issue, presence: true
end
