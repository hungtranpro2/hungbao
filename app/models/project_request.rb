class ProjectRequest < ApplicationRecord
  PARAMS = %i(title description document_link client_company division_id project_id project_leader).freeze

  belongs_to :project
  belongs_to :division

  validates :title, presence: true
  validates :division_id, presence: true
  validates :project_id, presence: true
  validates :description, presence: true
  validates :client_company, presence: true
end
