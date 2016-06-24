class Category < ActiveRecord::Base
  has_many :products

  validates :name, presence: true
  scope :order_by_name, -> {order name: :asc}
end
