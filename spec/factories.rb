FactoryGirl.define do
  sequence(:email){ |n| "test#{n}@test.com" }

  factory :user do
    email
    password '12345678'
  end

  factory :farm_store_order do

  end

  # factory :store do
  #   standard_tax_rate Random.rand(0.01..20.0)
  # end

  factory :farm_store_item do
    name Faker::Commerce.product_name
    quantity Random.rand(0..10000000).round(0)

    factory :item_with_pricing do
      after(:build) do |item, e|
        item.farm_store_pricings << build(:farm_store_pricing)
      end
    end
  end

  factory :farm_store_pricing do
    name Faker::Lorem.word
    price Random.rand(0.01..100000)
    quantity Random.rand(1..144).round(0)
  end

  factory :farm_store_order_item do

  end
end