# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'market vendor requests', type: :request do
  describe 'create vendor markets' do
    it 'can create a market_vendor and will not allow duplicates' do
      @vendor4 = Vendor.create(name: 'BOMBA', description: 'Big boom', contact_name: 'Vladdy Daddy',
                               contact_phone: '(404) 404-0404', credit_accepted: true)
      @market4 = Market.create(name: 'Bomba Market', street: 'P. Sharman, 45 Wallaby Way', city: 'Syndey',
                               county: 'Cumberland', state: 'New South Wales', zip: '2000', lat: '38.9169984', lon: '-77.0320505')

      post '/api/v0/market_vendors', params: { market_id: @market4.id, vendor_id: @vendor4.id }

      expect(response.status).to eq(201)

      data = JSON.parse(response.body, symbolize_names: true)
      expect(data[:message]).to eq('Successfully added vendor to market')

      post '/api/v0/market_vendors', params: { market_id: @market4.id, vendor_id: @vendor4.id }

      data = JSON.parse(response.body, symbolize_names: true)
      expect(data[:errors][0][:detail]).to eq("Validation failed: Market vendor asociation between market with market_id=#{@market4.id} and vendor_id=#{@vendor4.id} already exists")

      expect(response.status).to eq(422)
    end

    it 'will check valid vendor' do
      @market2 = Market.create!(name: 'The Worst Market', street: 'P. Sharman, 43 Wallaby Way', city: 'Syndey',
                                county: 'Cumberland', state: 'New South Wales', zip: '2000', lat: '38.9169984', lon: '-77.0320505')

      post '/api/v0/market_vendors', params: { market_id: @market2.id, vendor_id: 123_123_123_123 }

      data = JSON.parse(response.body, symbolize_names: true)
      expect(data[:errors][0][:detail]).to eq('Validation failed: Vendor must exist')

      expect(response.status).to eq(404)
    end

    it 'will check valid market' do
      @vendor2 = Vendor.create!(name: 'Sun City Vendor', description: 'Just a vendor, homie', contact_name: 'Sean Cowans',
                                contact_phone: '(915) 915-9150', credit_accepted: true)

      post '/api/v0/market_vendors', params: { market_id: 0, vendor_id: @vendor2.id }

      data = JSON.parse(response.body, symbolize_names: true)
      expect(data[:errors][0][:detail]).to eq('Validation failed: Market must exist')

      expect(response.status).to eq(404)
    end
  end

  describe 'delete vendor markets' do
    before :each do
      markets_and_vendors
    end

    it 'can delete a vendor market' do
      delete '/api/v0/market_vendors', params: { market_id: @market1.id, vendor_id: @vendor1.id }
      expect(response.status).to eq(204)
    end

    it 'will give 404 with errors for bad id' do
      delete '/api/v0/market_vendors', params: { market_id: 0, vendor_id: @vendor1.id }
      expect(response.status).to eq(404)
      data = JSON.parse(response.body, symbolize_names: true)
      expect(data[:errors][0][:detail]).to eq("Validation failed: No MarketVendor with market_id=0 AND vendor_id=#{@vendor1.id} exists")

      delete '/api/v0/market_vendors', params: { market_id: @market1.id, vendor_id: 0 }
      expect(response.status).to eq(404)
      data = JSON.parse(response.body, symbolize_names: true)
      expect(data[:errors][0][:detail]).to eq("Validation failed: No MarketVendor with market_id=#{@market1.id} AND vendor_id=0 exists")

      delete '/api/v0/market_vendors', params: { market_id: @market4.id, vendor_id: @vendor4.id }
      expect(response.status).to eq(404)
      data = JSON.parse(response.body, symbolize_names: true)
      expect(data[:errors][0][:detail]).to eq("Validation failed: No MarketVendor with market_id=#{@market4.id} AND vendor_id=#{@vendor4.id} exists")
    end
  end
end
