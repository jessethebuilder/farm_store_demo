require 'rails_helper'

describe FarmStoreProfile, type: :model do
  describe 'Validations' do
    it{ should validate_presence_of :standard_tax_rate }
    it{ should validate_numericallity_of :standard_tax_rate }
  end

  describe 'Associations' do
    it{ should belong_to :has_farm_store_profile }
  end
end