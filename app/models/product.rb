require 'yandex'

class Product < ActiveRecord::Base
  validates :name, :price, presence: true
  has_many :offers

  def has_offers?
    self.offers.any?
  end

  def get_yandex_offers
    
    pr = MarketYandex.search name
      
    if has_offers?
      offers = Offer.where(:product_id => id)
      offers.each { |o| o.destroy }
    end

    pr.each do |pr|
      o = Offer.new
      o.price = pr.split('.....', 3)[0]
      o.shop  = pr.split('.....', 3)[1]
      o.url   = pr.split('.....', 3)[2]
      o.product_id = id
      o.save
    end

  end

end
