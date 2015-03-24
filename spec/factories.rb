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

    after(:build) do |item, e|
      item.pricing[Faker::Lorem.word] = Random.rand(0.01..100000).round(2)
    end
  end

  factory :farm_store_order_item do

  end
end