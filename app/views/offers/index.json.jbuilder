json.array!(@offers) do |offer|
  json.extract! offer, :id, :shop, :price, :url
  json.url offer_url(offer, format: :json)
end
