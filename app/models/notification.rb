class Notification < ApplicationRecord
  after_create :send_notification

  enum status: {waiting: 0, approval: 1, rejected: 2}

  belongs_to :sender, class_name: User.name, foreign_key: :sender_id
  belongs_to :receiver, class_name: User.name, foreign_key: :receiver_id
  belongs_to :object, polymorphic: true

  def send_notification
    NotificationBroadcastJob.perform_now(self, sender.name)
  end
end
