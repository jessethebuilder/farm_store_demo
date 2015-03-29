require 'rails_helper'

describe FarmStorePricing, :type => :model do
  let(:pricing){ build :farm_store_pricing }
  let(:item){ create :item_with_pricing }

  describe 'Validations' do
    it{ should validate_presence_of :name }

    it{ should validate_presence_of :price }
    it{ should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }

    it{ should validate_presence_of :quantity }
    it{ should validate_numericality_of(:quantity).is_greater_than_or_equal_to(1) }
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
  end # Attributes

  describe 'Methods' do
    describe '#maximum_order_quantity(farm_store_item)' do
      it 'should return the maximum order quantity for the pricing' do
        p = item.farm_store_pricings.first
        p.quantity = 12
        item.quantity = 35
        item.save!

        p.maximum_order_quantity(item).should == 2

        item.quantity = 36
        item.save

        p.maximum_order_quantity(item).should == 3
      end

      it "should return 0 if the Item's #quantity is less than the pricing #quantity" do
        p = item.farm_store_pricings.first
        p.quantity = 144
        item.quantity = 100
        item.save!

        p.maximum_order_quantity(item).should == 0
      end
    end
  end
end