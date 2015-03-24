class Store < ActiveRecord::Base
  has_many :farm_store_profiles, as: :has_farm_store_profile
end
