require 'rails_helper'

describe FarmStoreOrderItem, :type => :model do
  #there is no db table for this model.
  let(:i){ create :farm_store_item }
  let(:o){ build :farm_store_order }

  let(:order_item) do
    FarmStoreOrderItem.new(i, i.pricing.keys.first, Random.rand(1..100))
  end

  before(:each) do

  end

  describe 'Methods' do
    describe '#new(item, pricing_key, quantity, price: nil)' do
      it 'should return a new FarmStoreOrderItem' do
        FarmStoreOrderItem.new(i, i.pricing.keys.first, Random.rand(1..1000)).class.should == FarmStoreOrderItem
      end

      it 'optionally, a :price parameter can be sent, which sets the price of the unit item, instead of a lookup by the pricing_key' do
        #done to cement a displayed price, when the model (and thus the item price)
        oi = FarmStoreOrderItem.new(i, i.pricing.keys.first, 1, price: 1000000) #1,000,000 is out of range of the sample data
        oi.total.should == 1000000
      end

    end

    describe '#item' do
      it 'returns the item that the FarmStoreOrderItem is derived from' do
        order_item.item.should == i
      end

      it 'should return nil if the item has been deleted' do
        i.destroy
        order_item.item.should == nil
      end
    end

    describe '#total' do
      it 'should return the price of the item times the quantity' do
        price = i.pricing.values.first
        order_item.total.should == price * order_item.quantity
      end

      it 'should work with real data' do
        i.pricing['test_price'] = 100
        i.save
        oi = FarmStoreOrderItem.new(i, 'test_price', 10)
        oi.total.should == 1000
      end

      it 'should save the price at the moment of creation, and not be linked to the db object item' do
        i.pricing['test'] = 100
        i.save
        oi = FarmStoreOrderItem.new(i, 'test', 1)
        i.pricing['test'] = 200
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
        item.pricing['test_price'] = 1000
        item.save
        order_item = FarmStoreOrderItem.new(item, 'test_price', 2)
        order_item.total_after_tax.should == 2200
      end


    end
  end
end