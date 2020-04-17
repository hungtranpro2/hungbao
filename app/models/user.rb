class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PARAMS_USER = %i(email name password password_confirmation staff_type workspace nationality position role division_id).freeze
  PARAMS_PROFILE = %i(name birthday phone skill gender avatar).freeze
  PARAMS_PASSWORD = %i(password).freeze

  enum role: {member: 0, manager: 1, hr: 2}
  enum staff_type: {EDU: 0, Intern: 1, Fresher: 2, Developer: 3}
  enum nationality: {Vietnam: 0, Japan: 1}
  enum workspace: {Hanoi: 0, DaNang: 1}
  enum gender: {Male: 0, Female: 1}
  enum position: {DEV: 0, QA: 1, HR: 2, ProjectManager: 3}

  belongs_to :division, class_name: Division.name, foreign_key: "division_id"
  has_many :user_projects, dependent: :destroy
  has_many :projects, through: :user_projects

  has_many :messages, dependent: :destroy
  has_many :list_messages, through: :messages
  has_many :tasks, dependent: :destroy

  has_many :personal_requests, dependent: :destroy
  has_many :reports, dependent: :destroy

  has_many :tasks

  has_many :notifications, class_name: Notification.name,
                           foreign_key: :receiver_id, dependent: :destroy

  validates :name, presence: true, length: {maximum: 50}


  mount_uploader :avatar, AvatarUploader
end
