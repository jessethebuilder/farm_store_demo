require 'rails_helper'

describe FarmStoreItem, :type => :model do
  let(:i){ build :farm_store_item }
  let(:pricing){ build :farm_store_pricing }
  
  describe 'Validations' do
    it{ should validate_presence_of :name }

    it{ should validate_presence_of :quantity }
    it{ should validate_numericality_of(:quantity).is_greater_than_or_equal_to(0) }
  end

  describe 'Associations' do
    it{ should have_many :farm_store_order_items }

    it{ should have_many(:farm_store_pricings).through(:farm_store_pricing_setters) }

    it{ should have_many(:farm_store_departments).through(:farm_store_department_setters) }
  end

  describe 'Attributes' do
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
    describe 'build_order_item(pricing, quantity: 1)' do
      it 'should return a FarmStoreOrderItem' do
        i.build_order_item(pricing).class.should == FarmStoreOrderItem
      end

      specify 'return value should be decorated with this FarmStoreItem' do
        i.build_order_item(pricing).name.should == i.name
      end

      specify 'default quantity is one' do
        i.build_order_item(pricing).quantity.should == 1
      end

      specify 'quantity can be changed with :quantity parameter' do
        i.build_order_item(pricing, :quantity => 100).quantity.should == 100
      end
    end

    describe 'available_pricings' do
      it 'should return an array of FarmStorePricings for which there is available quantity' do
        i = FarmStoreItem.new(:name => Faker::Commerce.product_name, :quantity => 100)
        p1 = FarmStorePricing.new(:name => Faker::Lorem.word, :quantity => 1, :price => Random.rand(0.01..10000))
        p2 = FarmStorePricing.new(:name => Faker::Lorem.word, :quantity => 12, :price => Random.rand(0.01..10000))
        p3 = FarmStorePricing.new(:name => Faker::Lorem.word, :quantity => 144, :price => Random.rand(0.01..10000))
        i.farm_store_pricings << [p1, p2, p3]
        i.save!

        pricings = i.available_pricings
        pricings.include?(p1).should == true
        pricings.include?(p2).should == true
        pricings.include?(p3).should == false
      end
    end
  end # Methods

  describe 'Class Methods' do
    describe 'Scopes' do
      describe '#in_stock' do
        it "should return items that have a quantity greater than 0" do
          i.quantity = 100
          expect{ i.save }.to change{ FarmStoreItem.in_stock.count }.by(1)
        end

        it "should not return items that have a quantity of 0" do
          i.quantity = 0
          expect{ i.save }.to_not change{ FarmStoreItem.in_stock.count }
        end
      end

      describe '#out_of_stock' do
        it "should return items that have a quantity of 0" do
          i.quantity = 0
          expect{ i.save }.to change{ FarmStoreItem.out_of_stock.count }.by(1)
        end

        it "should not return items that have a quantity of greater than 0" do
          i.quantity = 1
          expect{ i.save }.to_not change{ FarmStoreItem.out_of_stock.count }
        end
      end
    end
  end #Class Methods
end