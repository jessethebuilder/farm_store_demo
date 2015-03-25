require 'rails_helper'

describe FarmStoreDepartmentSetter, :type => :model do
  describe 'Validations' do

  end

  describe 'Associations' do
    it{ should belong_to :farm_store_department }
    it{ should belong_to :farm_store_item }
  end
end