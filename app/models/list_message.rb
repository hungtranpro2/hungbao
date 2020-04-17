class ListMessage < ApplicationRecord
	enum type_mes: {friend: 0, project: 1, my_chat: 2}
	has_many :messages,  dependent: :destroy
  has_many :user, through: :messages

   validates :name, presence: true, uniqueness: true
end
