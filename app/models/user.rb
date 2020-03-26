class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PARAMS_PROFILE = %i(name birthday phone skill gender avatar).freeze
  PARAMS_PASSWORD = %i(password).freeze

  enum role: {member: 0, manager: 1, admin: 2}
  enum staff_type: {EDU: 0, Intern: 1, Fresher: 2, Developer: 3}
  enum nationality: {Vietnam: 0, Japan: 1}
  enum workspace: {Hanoi: 0, DaNang: 1}
  enum gender: {Male: 0, Female: 1}
  enum position: {DEV: 0, QA: 1, HR: 2}

  has_many :user_projects, dependent: :destroy
  has_many :projects, through: :user_projects

  has_many :messages, dependent: :destroy
  has_many :list_messages, through: :messages

  validates :name, presence: true, length: {maximum: 50}
  validates :phone, :numericality => true, presence: true
  validates :skill, presence: true

  mount_uploader :avatar, AvatarUploader
end
