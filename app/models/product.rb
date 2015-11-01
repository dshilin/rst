require 'yandex'

class Product < ActiveRecord::Base
  validates :name, :price, presence: true
  has_many :offers

  def has_offers?
    @offers.nil?
  end

  def get_yandex_offers
    pr = MarketYandex.search name
    pr.each do |pr|
      o = Offer.new
      o.price = pr.split('_', 3)[0]
      o.shop  = pr.split('_', 3)[1]
      o.url   = pr.split('_', 3)[2]
      o.product_id = id 
      if has_offers?
        Offer.update
      else
        Offer.create
      end
    end
  end

end
