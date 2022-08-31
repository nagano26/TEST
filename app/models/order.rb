class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product
  validates :order_number, presence: true, numericality: { greater_than_or_equal_to: 1, less_than: 10 }
  before_create :order_datetime!

  def order_sumprice
    (self.order_number * product.product_price)
  end
  
  def order_datetime!
    self.order_datetime = Time.now
  end

  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
end
