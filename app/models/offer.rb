class Offer < ActiveRecord::Base
  validates :shop, :price, :url, presence: true
  belongs_to :product
end
