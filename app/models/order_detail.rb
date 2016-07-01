class OrderDetail < ActiveRecord::Base
  belongs_to :product
  belongs_to :order

  validates :quantity, presence: true, numericality: {only_integer: true, greater_than: 0}
  validates :unit_price, presence: true, numericality: {only_decimal: true, greater_than: 0}
  
  before_save :finalize
  after_destroy :update_order_price
  
  def unit_price
    if persisted?
      self[:unit_price]
    else
      product.price
    end
  end

  private
  def finalize
    self[:unit_price] = unit_price
  end

  def update_order_price
    order[:total_pay] = order.subtotal
    order.save
  end
end
