# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MarketVendor, type: :model do
  describe 'relationships' do
    it { should belong_to :market }
    it { should belong_to :vendor }
  end

  it 'validates uniqueness' do
    @market1 = Market.create!(name: 'The Best Market', street: 'P. Sharman, 42 Wallaby Way', city: 'Syndey',
                              county: 'Cumberland', state: 'New South Wales', zip: '2000', lat: '38.9169984', lon: '-77.0320505')

    @vendor1 = Vendor.create!(name: 'Elm Street Vendor', description: 'Just a vendor, homie',
                              contact_name: 'Freddy Krueger', contact_phone: '(911) 911-0911', credit_accepted: true)
    @market_vendor1 = MarketVendor.create!(vendor_id: @vendor1.id, market_id: @market1.id)

    expect do
      MarketVendor.create!(market_id: @market1.id, vendor_id: @vendor1.id)
    end.to raise_error(ActiveRecord::RecordInvalid)
  end
end
