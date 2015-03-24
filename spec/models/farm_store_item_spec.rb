require 'rails_helper'

describe FarmStoreItem, :type => :model do
  let(:i){ build :farm_store_item }
  let(:pricing_key){ i.pricing.first }
  
  describe 'Validations' do
    it{ should validate_presence_of :name }
    it{ should validate_presence_of :pricing }
  end

  describe 'Associations' do

  end

  describe 'Attributes' do
    describe '#pricing' do
      it 'should be a Hash' do
        FarmStoreItem.new.pricing.should == {}
      end
    end

    describe '#tax_rate' do
      it 'should be a float' do
        i.tax_rate.class.should == Float
      end

      it 'should be the value set by #tax_rate=' do
        i.tax_rate = 10
        i.tax_rate.should == 0.10
      end

      it 'should return the value in the constant FARM_STORE_TAX_RATE' do
        #FARM_STORE_TAX_RATE is currently set in an initializer by hand. It happens to be 9.2 right now.
        i.tax_rate.should == 0.092
      end
    end
  end #end Attributes

  describe 'Methods' do
    describe 'build_order_item(pricing_key, quantity: 1)' do
      it 'should return a FarmStoreOrderItem' do
        i.build_order_item(pricing_key).class.should == FarmStoreOrderItem
      end

      specify 'return value should be decorated with this FarmStoreItem' do
        i.build_order_item(pricing_key).name.should == i.name
      end

      specify 'default quantity is one' do
        i.build_order_item(pricing_key).quantity.should == 1
      end

      specify 'quantity can be changed with :quantity parameter' do
        i.build_order_item(pricing_key, :quantity => 100).quantity.should == 100
      end
    end
  end
end