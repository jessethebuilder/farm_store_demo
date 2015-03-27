if Store.count == 0
  s = Store.new tax_rate: 9.2
  s.save!
end

def a_price
  Random.rand(0.01..1000)
end

4.times do
  p = FarmStorePricing.create! name: Faker::Lorem.word, price: a_price, :quantity => Random.rand(1..144)
end

10.times do
  f = FarmStoreItem.new :name => Faker::Commerce.product_name, :quantity => Random.rand(1..10000)
  Random.rand(1..3).times do
    pricing = FarmStorePricing.all.sample
    f.farm_store_pricings << pricing unless f.farm_store_pricings.include?(pricing)
  end
  f.save!
end