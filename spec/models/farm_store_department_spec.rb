require 'rails_helper'

describe FarmStoreDepartment, :type => :model do
  describe 'Validations' do
    it{ should validate_presence_of :name }
    it{ should validate_uniqueness_of :name }
  end

  describe 'Associations' do
    it{ should have_many(:farm_store_department_setters) }
    it{ should have_many(:farm_store_items).through(:farm_store_department_setters) }
  end

end