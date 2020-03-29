class Project < ApplicationRecord
  PARAMS = %i(name description ).freeze

	has_many :user_projects, dependent: :destroy
  has_many :users, through: :user_projects

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  belongs_to :division, class_name: Division.name, foreign_key: :division_id

end
