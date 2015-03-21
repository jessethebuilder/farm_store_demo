require 'rails_helper'

describe FarmStoreOrder, :type => :model do
  let(:o){ build :farm_store_order }
  let(:i){ create :farm_store_item}
  
  describe 'Validations' do
    it{ should validate_presence_of :phase }
    it{ should validate_inclusion_of(:phase).in_array(%w|open completed sent delivered returned|) }
  end

  describe 'Associations' do
    it{ should belong_to :makes_orders }
  end
  
  describe 'Attributes' do
    describe '#phase' do
      it 'should be "open" when order is created' do
        FarmStoreOrder.new.phase.should == 'open'
      end
    end

    describe '#items' do
      it 'should be an array by default' do
        FarmStoreOrder.new.items.should == []
      end
      

      describe '#billing_address' do
      #   it 'should return any kind of data you put in it' do
      #     #the idea here is that an address is stamped into the database at the moment of order completion.
      #     o.billing_address = 'some data'
      #     o.billing_address.class.should == String
      #     o.billing_address = []
      #     o.billing_address.class.should == Array
      #   end
      end
      
      describe '#shipping_address' do
        # it 'should be a JSON object' do
        #   o.shipping_address = 'some data'
        #   o.shipping_address.class.should == JSON
        # end
      end
    end
  end # Attributes

  describe 'Methods' do
    describe 'Total Methods' do
      before(:each) do
        item = FarmStoreItem.new :name => Faker::Commerce.product_name
        item.pricing['test'] = 100
        item.tax_rate = 10
        item.save

        10.times do
          f = FarmStoreOrderItem.new item, 'test', 1
          o.items << f
        end
      end

      describe '#total' do
        it 'should return the total of all the items' do
          o.total.should == 1000
        end
      end

      describe '#total_after_tax' do
        it 'should return the total of all items, including tax' do
          #precice to 3 decimal places
          o.total_after_tax.round(3).should == 1100
        end
      end
    end
  end # Methods

  describe 'Class Methods' do
    describe 'Scopes' do
      describe 'open' do
        let(:u){ create :user }
        let(:o2){ create :farm_store_order, :phase => 'sent' }
        let(:o1){ create :farm_store_order }
        before(:each) do
          u.farm_store_orders << [o1, o2]
        end

        it 'should return the open order' do
          u.farm_store_orders.open.first.should == o1
        end

      end
    end
  end # Class Methods
end
