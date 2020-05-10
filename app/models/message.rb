class Message < ApplicationRecord
  PARAMS = %i{user_id list_message_id content}

  after_create_commit :send_message

	belongs_to :list_message
  belongs_to :user
  has_many :notifications, as: :object

  validates :content, length: {maximum: 255}

  private

  def send_message
    MessageBroadcastJob.perform_later(self)
  end
end
