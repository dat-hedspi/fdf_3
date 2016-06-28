class Suggestion < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 140}

  scope :order_by_time, -> {order created_at: :desc}
end
