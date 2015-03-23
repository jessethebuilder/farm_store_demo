require 'rails_helper'

describe FarmStoreOrder, :type => :model do
  let(:o){ build :farm_store_order }
  let(:i){ create :farm_store_item}
  let(:pricing_key){ i.pricing.keys.first }
  let(:oi){ i.build_order_item(pricing_key, :quantity => Random.rand(1..1000)) }
  
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

      it 'should return an array of FarmStoreOrderItems' do
        o.items << oi
        o.items.first.class.should == FarmStoreOrderItem
      end

      it "should return an array of FarmStoreOrderItems after it is saved" do
        o.items << oi
        o.save

        refetched_order = o.reload
        refetched_order.items.class == Array
        refetched_order.items.first.class.should == FarmStoreOrderItem
      end

      it 'should accept and save FarmStoreOrderItems' do
        o.save
        order_id = o.id
        o.items << oi
        o.items.include?(oi).should == true
        o.save
        FarmStoreOrder.find(order_id).items.first.item_id.should == i.id
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
          o.items << item.build_order_item('test')
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
