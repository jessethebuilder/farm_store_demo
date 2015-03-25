require 'rails_helper'

describe FarmStoreOrderItem, :type => :model do
  let(:i){ create :farm_store_item }
  let(:o){ build :farm_store_order }
  let(:pricing){ create :farm_store_pricing }
  let(:order_item){ i.build_order_item(pricing) }

  describe 'Validations' do
  end # Validations

  describe 'Associations' do
    it{ should belong_to :farm_store_order }
    it{ should belong_to :farm_store_item }
    it{ should belong_to :farm_store_pricing }
  end

  describe 'Methods' do
    describe '#total' do
      before(:each) do
        i.farm_store_pricings << pricing
        i.save!
      end

      it 'should return the price of the item times the quantity' do
        price = i.farm_store_pricings.first.price
        order_item.total.should == price * order_item.quantity
      end

      it 'should work with real data' do
        i.farm_store_pricings.first.price = 100
        i.save
        oi = i.build_order_item(i.farm_store_pricings.first, :quantity => 10)
        oi.total.should == 1000
      end

      it 'should save the price at the moment of creation, and not be linked to the db object item' do
        i.farm_store_pricings.first.price = 100
        i.save
        oi = i.build_order_item(i.farm_store_pricings.first)
        i.farm_store_pricings.first.price = 200
        oi.total.should == 100
      end
    end

    describe '#total_after_tax' do
      it 'should work, even if no tax rate is defined' do
        #This actually tests the implementation of the Standard Tax Rate in this demo, but needs to pass
        #if FarmStore is going to work.
        order_item.total_after_tax.class.should == Float
      end

      it 'should work with real numbers' do
        item = FarmStoreItem.new :name => Faker::Commerce.product_name, tax_rate: 10
        pricing.price = 1000
        item.farm_store_pricings << pricing
        # item.save
        order_item = item.build_order_item(item.farm_store_pricings.last)
        order_item.total_after_tax.should == 1100
      end
    end
  end #Methods

  describe 'Class Methods' do
    describe 'Scopes' do
    end
  end #Class Methods
end