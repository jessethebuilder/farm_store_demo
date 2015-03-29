require 'rails_helper'

# describe 'FarmStoreItem Requests', :type => :feature, :js => true do
describe 'FarmStoreItem Requests', :type => :feature do
  # let!(:item){ create :farm_store_item }
  before(:each) do
    10.times do
      create :farm_store_item
    end
  end

  describe 'Index' do
    before(:each) do
      visit '/farm_store_items'
    end

    describe 'Deleting Items' do
      it 'should delete the OrderItem when delete is clicked' do
        expect{ click_link("delete", :match => :first) }.to change{ FarmStoreItem.count }.by(-1)
      end
    end
  end

end