class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  validates :content, presence: true, length: {maximum: 50}

  scope :order_by_time, -> {order created_at: :desc}
end
