class Product < ApplicationRecord
  def self.search(keyword)
    where(["product_name like? OR product_name_kana like?", "%#{keyword}%", "%#{keyword}%"])
  end
  
  def self.zaiko_search(from = nil, to = nil)
    from = 0 if from.blank?
    to = Float::INFINITY if to.blank?
    #binding.pry 
    where(product_zaiko: from..to)
  end

  def self.price_search(from_price, to_price )
    from_price = 0 if from_price.blank?
    to = Float::INFINITY if to_price.blank?
    where(product_price: from_price..to_price)
  end

  validates :product_zaiko, presence: true, 
    numericality: {only_integer: true, 
                   greater_than_or_equal_to: 0, 
                   less_than_or_equal_to: 999999999999}

  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  

end
