class Task < ApplicationRecord

  PARAMS = %i(name description start_day end_day path_github progess time_reality estimated_time priority project_id user_id).freeze

  belongs_to :user
  belongs_to :project

  enum priority: {low: 0, normal:1, high: 2}
end
