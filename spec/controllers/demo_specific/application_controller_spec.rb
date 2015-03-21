require 'rails_helper'

describe ApplicationController, type: :controller do
  describe '#current_user' do
    login_user

    it 'should have a current_user' do
      subject.current_user.should_not be_nil
    end

    specify 'current user should be the one that is signed in' do
      subject.current_user.should == @user
    end
  end

  describe '#current_order' do
    # #current_order is a cornerstone of FarmStore. It expects current_order to be available, and to be the correct
    # order to place FarmStoreOrderItems on. The FarmStore gem does not, how ever, implement this method in any way.
    it 'should be a FarmStoreOrder' do
      subject.current_order.class.should == FarmStoreOrder
    end

    it 'should have a phase of open' do
      subject.current_order.phase.should == 'open'
    end

    context 'User is signed in' do
      login_user

      it 'should return a new (but saved) order, if no open order is available' do
        #current_order is generally called when an item is added, so calling current_order creates it, if it doesn't exist.
        order = subject.current_order
        @user.farm_store_orders.open.first.should == order
        subject.current_order.items.blank?.should == true
      end

      it 'should return the "open" order, if it exists' do
        order = FarmStoreOrder.create(:phase => 'open')
        @user.farm_store_orders << order
        subject.current_order.should == order
      end
    end

    context 'User is not signed in' do
      it 'should return a new (but saved) FarmStoreOrder, if not open order is available on the session' do
        expect{subject.current_order}.to change{ FarmStoreOrder.open.count }.by(1)
        subject.current_order.items.blank?.should == true
      end

      it 'should return an existing FarmStoreOrder, if one has been associated with the session' do
        order = subject.current_order
        subject.current_order.should == order
      end

      it 'should be the order associated with the session key :farm_store_order_id' do
        order = subject.current_order
        order.should == FarmStoreOrder.find(subject.session[:farm_store_order_id])
      end
    end
  end #current_order
end

