require 'rails_helper'

describe FarmStorePricing, :type => :model do
  describe 'Validations' do
    it{ should validate_presence_of :name }

    it{ should validate_presence_of :price }
    it{ should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }

    it{ should validate_presence_of :quantity }
    it{ should validate_numericality_of(:quantity).is_greater_than_or_equal_to(0) }
  end

  describe 'Associations' do
    it{ should have_many(:farm_store_pricing_setters) }
    it{ should have_many(:farm_store_items).through(:farm_store_pricing_setters) }
  end
end