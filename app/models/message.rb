class Message < ApplicationRecord
  PARAMS = %i{user_id list_message_id content}

  after_create_commit :send_message

	belongs_to :list_message
  belongs_to :user

  validates_presence_of :content

  private

  def send_message
    MessageBroadcastJob.perform_later(self)
  end
end
