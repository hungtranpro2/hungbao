class ListMessage < ApplicationRecord
	enum type_mes: {friend: 0, project: 1}
	has_many :messages
end
