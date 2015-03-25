require 'rails_helper'

describe FarmStoreItemsController, type: :controller do
  let(:pricing){ create :farm_store_pricing }
  let(:valid_attributes){ {name: Faker::Commerce.product_name, quantity: Random.rand(0.0..1000.0), :farm_store_pricing_id => pricing.id} }
  let(:invalid_attributes){ {quantity: -1} }
  let(:valid_session){ {} }

  describe "GET #index" do
    it "assigns all tests as @farm_store_items" do
      item = FarmStoreItem.create! valid_attributes
      get :index, {}, valid_session
      assigns(:farm_store_items).should == [item]
    end
  end

  describe "GET #show" do
    it "assigns the requested test as @farm_store_item" do
      item = FarmStoreItem.create! valid_attributes
      get :show, {:id => item.to_param}, valid_session
      assigns(:farm_store_item).should == item
    end
  end

  describe "GET #new" do
    it "assigns a new FarmStoreOrdreItem as @farm_store_order_item" do
      get :new, {}, valid_session
      assigns(:farm_store_item).should be_a_new(FarmStoreItem)
    end
  end

  describe "GET #edit" do
    it "assigns the requested FarmStoreItem as @farm_store_item" do
      item = FarmStoreItem.create! valid_attributes
      get :edit, {:id => item.to_param}, valid_session
      assigns(:farm_store_item).should == item
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new FarmStoreItem" do
        expect {
          post :create, {:farm_store_item => valid_attributes}, valid_session
        }.to change(FarmStoreItem, :count).by(1)
      end

      it "assigns a newly created test as @test" do
        post :create, {:farm_store_item => valid_attributes}, valid_session
        expect(assigns(:farm_store_item)).to be_a(FarmStoreItem)
        expect(assigns(:farm_store_item)).to be_persisted
      end

      it "redirects to the created test" do
        post :create, {:farm_store_item => valid_attributes}, valid_session
        expect(response).to redirect_to(FarmStoreItem.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved test as @test" do
        post :create, {:farm_store_item => invalid_attributes}, valid_session
        expect(assigns(:farm_store_item)).to be_a_new(FarmStoreItem)
      end

      it "re-renders the 'new' template" do
        post :create, {:farm_store_item => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    let(:new_attributes) { {name: Faker::Commerce.product_name, quantity: Random.rand(0..1000), :farm_store_pricing_id => pricing.id} }
    let(:item){ FarmStoreItem.create! valid_attributes }

    context "with valid params" do
      before(:each){
        put :update, {:id => item.to_param, :farm_store_item => new_attributes}, valid_session
      }

      it "updates the requested FarmStoreItem" do
        item.reload
        item.name.should == new_attributes[:name]
        item.quantity.should == new_attributes[:quantity]
      end

      it "assigns the requested item as @farm_store_item" do
        assigns(:farm_store_item).should == item
      end

      it "redirects to the FarmStoreItem" do
        expect(response).to redirect_to(item)
      end
    end

    context "with invalid params" do
      before(:each) do
        put :update, {:id => item.to_param, :farm_store_item => invalid_attributes}, valid_session
      end

      it "assigns the item as @farm_store_item" do
        assigns(:farm_store_item).should == item
      end

      it "re-renders the 'edit' template" do
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    let(:item){ FarmStoreItem.create! valid_attributes }

    it "destroys the requested FarmStoreItem" do
      expect {
        delete :destroy, {:id => item.to_param}, valid_session
      }.to change(FarmStoreItem, :count).by(-1)
    end

    it "redirects to the FarmStoreItem list" do
      delete :destroy, {:id => item.to_param}, valid_session
      expect(response).to redirect_to(farm_store_items_url)
    end
  end
end