class Task < ApplicationRecord
  PARAMS = %i{user_id project_id title start_time end_time description percent progess reality_time path_github}
  enum percent: {close: 0, in_process: 1, finished: 2}

  belongs_to :user
  belongs_to :project
  belongs_to :parent, class_name: Task.name, optional: true

  validates :title, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :path_github, presence: true
end
