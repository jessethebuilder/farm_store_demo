require 'rails_helper'

describe FarmStoreItemsController, type: :controller do
  let(:pricing){ {Faker::Lorem.word => {'price' => Random.rand(0.01..100000), 'quantity' => Random.rand(1..10000)}} }
  let(:valid_attributes){ {name: Faker::Commerce.product_name, quantity: Random.rand(0.0..1000.0), :pricing => pricing} }
  let(:invalid_attributes){ {} }
  let(:valid_session){ {} }

  describe "GET #index" do
    it "assigns all tests as @farm_store_items" do
      item = FarmStoreItem.create! valid_attributes
      get :index, {}, valid_session
      assigns(:farm_store_items).should == [item]
    end
  end


  # describe "GET #show" do
  #   it "assigns the requested test as @test" do
  #     test = Test.create! valid_attributes
  #     get :show, {:id => test.to_param}, valid_session
  #     expect(assigns(:test)).to eq(test)
  #   end
  # end
  #
  # describe "GET #new" do
  #   it "assigns a new test as @test" do
  #     get :new, {}, valid_session
  #     expect(assigns(:test)).to be_a_new(Test)
  #   end
  # end
  #
  # describe "GET #edit" do
  #   it "assigns the requested test as @test" do
  #     test = Test.create! valid_attributes
  #     get :edit, {:id => test.to_param}, valid_session
  #     expect(assigns(:test)).to eq(test)
  #   end
  # end
  #
  # describe "POST #create" do
  #   context "with valid params" do
  #     it "creates a new Test" do
  #       expect {
  #         post :create, {:test => valid_attributes}, valid_session
  #       }.to change(Test, :count).by(1)
  #     end
  #
  #     it "assigns a newly created test as @test" do
  #       post :create, {:test => valid_attributes}, valid_session
  #       expect(assigns(:test)).to be_a(Test)
  #       expect(assigns(:test)).to be_persisted
  #     end
  #
  #     it "redirects to the created test" do
  #       post :create, {:test => valid_attributes}, valid_session
  #       expect(response).to redirect_to(Test.last)
  #     end
  #   end
  #
  #   context "with invalid params" do
  #     it "assigns a newly created but unsaved test as @test" do
  #       post :create, {:test => invalid_attributes}, valid_session
  #       expect(assigns(:test)).to be_a_new(Test)
  #     end
  #
  #     it "re-renders the 'new' template" do
  #       post :create, {:test => invalid_attributes}, valid_session
  #       expect(response).to render_template("new")
  #     end
  #   end
  # end
  #
  # describe "PUT #update" do
  #   context "with valid params" do
  #     let(:new_attributes) {
  #       skip("Add a hash of attributes valid for your model")
  #     }
  #
  #     it "updates the requested test" do
  #       test = Test.create! valid_attributes
  #       put :update, {:id => test.to_param, :test => new_attributes}, valid_session
  #       test.reload
  #       skip("Add assertions for updated state")
  #     end
  #
  #     it "assigns the requested test as @test" do
  #       test = Test.create! valid_attributes
  #       put :update, {:id => test.to_param, :test => valid_attributes}, valid_session
  #       expect(assigns(:test)).to eq(test)
  #     end
  #
  #     it "redirects to the test" do
  #       test = Test.create! valid_attributes
  #       put :update, {:id => test.to_param, :test => valid_attributes}, valid_session
  #       expect(response).to redirect_to(test)
  #     end
  #   end
  #
  #   context "with invalid params" do
  #     it "assigns the test as @test" do
  #       test = Test.create! valid_attributes
  #       put :update, {:id => test.to_param, :test => invalid_attributes}, valid_session
  #       expect(assigns(:test)).to eq(test)
  #     end
  #
  #     it "re-renders the 'edit' template" do
  #       test = Test.create! valid_attributes
  #       put :update, {:id => test.to_param, :test => invalid_attributes}, valid_session
  #       expect(response).to render_template("edit")
  #     end
  #   end
  # end
  #
  # describe "DELETE #destroy" do
  #   it "destroys the requested test" do
  #     test = Test.create! valid_attributes
  #     expect {
  #       delete :destroy, {:id => test.to_param}, valid_session
  #     }.to change(Test, :count).by(-1)
  #   end
  #
  #   it "redirects to the tests list" do
  #     test = Test.create! valid_attributes
  #     delete :destroy, {:id => test.to_param}, valid_session
  #     expect(response).to redirect_to(tests_url)
  #   end
  # end

end