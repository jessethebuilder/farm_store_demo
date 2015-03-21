require 'rails_helper'

describe FarmStoreItem, :type => :model do
  let(:i){ build :farm_store_item }

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
  end
end