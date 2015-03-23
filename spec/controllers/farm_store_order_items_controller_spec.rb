require 'rails_helper'

#relies on a controller method called #current_order
describe FarmStoreOrderItemsController, type: :controller do
  let(:farm_store_item){ create :farm_store_item }
  let(:pricing_key){ farm_store_item.pricing.keys.first }
  let(:valid_attributes){ {:item_id => farm_store_item.id, :pricing_key => pricing_key, :quantity => 1..1000} }
  let(:invalid_attributes){ {} }
  let(:valid_session){ {} }

  before(:each) do
    @item = create :farm_store_item
  end

  describe ':create' do
    context 'with valid params' do
      it 'creates a current_order if one does not exist' do
        # The FarmStore gem uses Ajax on all order_item requests
        expect{ xhr :post, :create, {:farm_store_order_item => valid_attributes}, valid_session}.to change(FarmStoreOrder, :count).by(1)
      end

      it 'adds FarmStoreOrderItem to the current_order' do
        xhr :post, :create, {:farm_store_order_item => valid_attributes}, valid_session
        oi = assigns(:farm_store_order_item)
        subject.current_order.items.first.price.should == oi.price
        subject.current_order.items.first.item_id.should == oi.item_id
      end

      it 'creates a new FarmStoreOrderItem and adds it to the current order' do
        expect{ xhr :post, :create, {:farm_store_order_item => valid_attributes}, valid_session}.to change{subject.current_order.items.count}.by(1)
      end

      it 'assigns a newly created test as @farm_store_order_item' do
        xhr :post, :create, {:farm_store_order_item => valid_attributes}, valid_session
        expect(assigns(:farm_store_order_item)).to be_a(FarmStoreOrderItem)
      end
    end

    context 'without valid params' do
      #parameters for this will be set by the system
    end
  end

end