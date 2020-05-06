class Project < ApplicationRecord
  PARAMS = %i(name description document_link importance client_company).freeze


  enum importance: {medium: 0, important: 1}
	has_many :user_projects, dependent: :destroy
  has_many :users, through: :user_projects
  has_many :divisions, through: :users
  has_many :reports, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :project_requests, dependent: :destroy
  has_many :personal_requests, dependent: :destroy

  has_many :tasks, dependent: :destroy


  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :client_company, presence: true
end
