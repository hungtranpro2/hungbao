class Task < ApplicationRecord
  PARAMS = %i{user_id project_id title start_time end_time description progess parent_id path_github}
  enum lock: {open: 0, close: 1}

  belongs_to :user
  belongs_to :project
  belongs_to :parent, class_name: Task.name, optional: true
  has_many :childrens, class_name: Task.name, foreign_key: :parent_id

  validates :title, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :path_github, presence: true
end
