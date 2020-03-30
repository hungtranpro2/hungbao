class ApprovalRequest < ApplicationRecord
  enum status: {waiting: 0, approval: 1, rejected: 2}
  enum send_for: {hr: 0, manager: 1}

  belongs_to :division, class_name: Division.name, foreign_key: :division_id
  belongs_to :personal_request, class_name: PersonalRequest.name, foreign_key: :personal_request_id
  has_many :notifications, as: :object

end
