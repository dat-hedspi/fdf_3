class Product < ActiveRecord::Base
  belongs_to :category
  
  has_attached_file :image, styles: {medium: "300x300", large: "450x450#"}
  has_many :comments, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_many :rates, dependent: :destroy

  validates :category_id, presence: true
  validates :description, presence: true
  validates :name, presence: true
  validates :number, presence: true
  validates :price, presence: true
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  
  scope :order_by, -> (filter, direction) {order filter + " " + direction}
  scope :order_by_rate, -> (direction){ 
    joins(:rates)
    .group("products.id")
    .order("avg(rates.vote) #{direction}")
  }
end
