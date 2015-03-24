require 'rails_helper'

describe FarmStoreProfile, type: :model do
  describe 'Validations' do
    it{ should validate_presence_of :standard_tax_rate }
    it{ should validate_numericality_of(:standard_tax_rate).is_greater_than_or_equal_to(0) }
  end

  describe 'Associations' do
    it{ should belong_to :has_farm_store_profile }
  end
end