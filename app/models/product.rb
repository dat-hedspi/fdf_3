class Product < ActiveRecord::Base
  belongs_to :category
  
  has_many :rates, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_many :comments, dependent: :destroy
end
