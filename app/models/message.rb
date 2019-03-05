class Message < ApplicationRecord
  belongs_to :user
  validates :body, presence: true, length: {minimum: 1}
  scope :latest_messages, -> {order(:created_at).last(20)}
end
