class Project < ApplicationRecord
  PARAMS = %i(name description).freeze

	has_many :user_projects, dependent: :destroy
  has_many :users, through: :user_projects
  has_many :divisions, through: :users

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

end
