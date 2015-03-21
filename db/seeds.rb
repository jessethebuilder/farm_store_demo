if Store.count == 0
  s = Store.new tax_rate: 9.2
  s.save!
end

def a_price
  Random.rand(0.01..1000)
end

10.times do
  f = FarmStoreItem.new :pricing => {'unit' => a_price, 'dozen' => a_price }, :name => Faker::Commerce.product_name, :tax_rate => Random.rand(0.01..20)
  f.save!
end