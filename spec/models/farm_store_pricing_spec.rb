require 'rails_helper'

describe FarmStorePricing, :type => :model do
  let(:pricing){ build :farm_store_pricing }

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

  describe 'Attributes' do
    describe '#price' do
      it 'should round values to the nearest 3 decimal places' do
        pricing.price = 1.12345
        pricing.price.should == 1.123

        pricing.price = 1.9876
        pricing.price.should == 1.988
      end
    end
  end
end