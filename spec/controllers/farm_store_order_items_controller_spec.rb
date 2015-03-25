require 'rails_helper'

#relies on a controller method called #current_order
describe FarmStoreOrderItemsController, type: :controller do
  let(:farm_store_item){ create :farm_store_item }
  let(:pricing){ create :farm_store_pricing }
  let(:order_item){ farm_store_item.build_order_item(pricing) }

  let(:valid_attributes){ {:farm_store_item_id => farm_store_item.id, :farm_store_pricing_id => pricing.id, :quantity => Random.rand(1..1000)} }
  let(:invalid_attributes){ {} }
  let(:valid_session){ {} }
  #
  # before(:each) do
  #   @item = create :farm_store_item
  # end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a current_order if one does not exist' do
        # The FarmStore gem uses Ajax on all order_item requests
        expect{ xhr :post, :create, {:farm_store_order_item => valid_attributes}, valid_session}.to change(FarmStoreOrder, :count).by(1)
      end

      it 'adds FarmStoreOrderItem to the current_order' do
        xhr :post, :create, {:farm_store_order_item => valid_attributes}, valid_session
        oi = assigns(:farm_store_order_item)
        subject.current_order.farm_store_order_items.first.price.should == oi.price
      end

      it 'creates a new FarmStoreOrderItem and adds it to the current order' do
        expect{ xhr :post, :create, {:farm_store_order_item => valid_attributes}, valid_session}.to change{subject.current_order.farm_store_order_items.count}.by(1)
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

  describe 'PUT #update' do
    context 'With Valid Params' do
      let(:new_item){ build :farm_store_item }
      let(:pricing){ create :farm_store_pricing }
      let(:new_attributes){ {:item_id => farm_store_item.id, :farm_store_pricing_id => pricing.id, :quantity => Random.rand(1..1000)} }
      let(:oi){ FarmStoreOrderItem.create! valid_attributes }

      before(:each) do
        xhr :put, :update, {:id => oi.to_param, :farm_store_order_item => new_attributes}, valid_session
        oi.reload
      end

      it 'updates the subject' do
        oi.quantity.should == new_attributes[:quantity]
      end

      it 'assigns the subject to @farm_store_order_item' do
        assigns(:farm_store_order_item).should == oi
      end

    end
  end

  describe 'DELETE #destroy' do
    before(:each) do
      subject.current_order.farm_store_order_items << order_item
      subject.current_order.save!
    end

    #deletes based on index. Uses the id param, as set up by Rails, as the index
    it 'deletes a FarmStoreOrderItem' do
      expect{ xhr :delete, :destroy, {:id => order_item.to_param}, valid_session }.to change{ subject.current_order.farm_store_order_items.count }.by(-1)
    end

    it 'assigns the id of the destroyed item to @destroyed_farm_store_order_item_id' do
      oi_id = order_item.to_param
      xhr :delete, :destroy, {:id => order_item.to_param}, valid_session
      assigns(:deleted_farm_store_order_item_id).should == Integer(oi_id)
    end
  end # destroy

end