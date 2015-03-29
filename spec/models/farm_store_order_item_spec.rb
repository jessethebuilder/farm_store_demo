require 'rails_helper'

describe FarmStoreOrderItem, :type => :model do
  let(:i){ create :farm_store_item }
  let(:o){ build :farm_store_order }
  let(:pricing){ create :farm_store_pricing }
  let(:order_item){ i.build_order_item(pricing) }

  before(:each) do
    i.farm_store_pricings << pricing
    i.save!
  end

  describe 'Validations' do
    it 'will not save if total_quantity exceeds quantity on the associated FarmStoreItem' do
      i.quantity = 100
      i.save

      pricing.quantity = 200
      pricing.save

      oi = i.build_order_item(pricing)
      oi.valid?.should == false
      oi.errors[:total_quantity].count.should == 1
    end
  end # Validations

  describe 'Associations' do
    it{ should belong_to :farm_store_order }
    it{ should belong_to :farm_store_item }
    it{ should belong_to :farm_store_pricing }
  end

  describe 'Methods' do
    describe '#total' do

      it 'should return the price of the item times the quantity' do
        price = i.farm_store_pricings.first.price
        order_item.total.should == price * order_item.quantity
      end

      it 'should work with real data' do
        pricing.price = 100
        oi = i.build_order_item(pricing, :quantity => 10)
        oi.total.should == 1000
      end

      it 'should save the price at the moment of creation, and not be linked to the db object item' do
        pricing.price = 100
        oi = i.build_order_item(pricing)
        oi.total.should == 100

        pricing.price = 200
        oi.price.should == 100
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

    describe '#total_quantity' do
      # Most pricings will be units like a Dozen or a Gross. #pricing_quatity may have a value like 12 or 144, which
      # will be multiplied by the quantity of items ordered.
      it 'should return the product of :quantity and the quantity on the pricing' do
        i = create :item_with_pricing
        quantity = Random.rand(1..10000)
        oi = i.build_order_item(i.farm_store_pricings.first, :quantity => quantity)
        oi.total_quantity.should == i.farm_store_pricings.first.quantity * quantity
      end

      it 'should work with real numbers' do
        i = create(:item_with_pricing)
        p = i.farm_store_pricings.first
        p.quantity = 12
        p.save
        i.reload
        oi = i.build_order_item(p, :quantity => 12)
        oi.total_quantity.should == 144
      end
    end

  end #Methods

  describe 'Class Methods' do
    describe 'Scopes' do
    end
  end #Class Methods
end