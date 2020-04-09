class Project < ApplicationRecord
  PARAMS = %i(name description document_link client_company).freeze

	has_many :user_projects, dependent: :destroy
  has_many :users, through: :user_projects
  has_many :divisions, through: :users
  has_many :reports, dependent: :destroy
  has_many :tasks, dependent: :destroy

  has_many :tasks, dependent: :destroy


  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

end
