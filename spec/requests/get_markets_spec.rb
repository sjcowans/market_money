# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'market requests', type: :request do
  describe 'all markets' do
    before :each do
      markets_and_vendors
      get '/api/v0/markets'
      @json = JSON.parse(response.body, symbolize_names: true)
    end

    it 'has status code 200' do
      expect(response).to have_http_status(:success)
    end

    it 'shows markets' do
      expect(@json[:data].length).to eq(4)
      expect(@json[:data][0][:attributes]).to have_key(:name)
      expect(@json[:data][0][:attributes][:name]).to be_a(String)
      expect(@json[:data][0][:attributes]).to have_key(:street)
      expect(@json[:data][0][:attributes][:street]).to be_a(String)
      expect(@json[:data][0][:attributes]).to have_key(:city)
      expect(@json[:data][0][:attributes][:city]).to be_a(String)
      expect(@json[:data][0][:attributes]).to have_key(:county)
      expect(@json[:data][0][:attributes][:county]).to be_a(String)
      expect(@json[:data][0][:attributes]).to have_key(:state)
      expect(@json[:data][0][:attributes][:state]).to be_a(String)
      expect(@json[:data][0][:attributes]).to have_key(:zip)
      expect(@json[:data][0][:attributes][:zip]).to be_a(String)
      expect(@json[:data][0][:attributes]).to have_key(:lat)
      expect(@json[:data][0][:attributes][:lat]).to be_a(String)
      expect(@json[:data][0][:attributes]).to have_key(:lon)
      expect(@json[:data][0][:attributes][:lon]).to be_a(String)
      expect(@json[:data][0][:attributes]).to have_key(:vendor_count)
      expect(@json[:data][0][:attributes][:vendor_count]).to be_a(Integer)
    end

    it 'has vendor count' do
      expect(@json[:data][0][:attributes][:vendor_count]).to eq(3)
      expect(@json[:data][1][:attributes][:vendor_count]).to eq(2)
      expect(@json[:data][2][:attributes][:vendor_count]).to eq(1)
      expect(@json[:data][3][:attributes][:vendor_count]).to eq(0)
    end
  end

  describe 'specific market' do
    before :each do
      markets_and_vendors
      get "/api/v0/markets/#{@market1.id}"
      @json = JSON.parse(response.body, symbolize_names: true)
    end

    it 'has status code 200' do
      expect(response).to have_http_status(:success)
    end

    it 'shows a specifc market' do
      expect(@json.length).to eq(1)
      expect(@json[:data][:attributes][:vendor_count]).to eq(3)
      expect(@json[:data][:id]).to eq(@market1.id.to_s)
      expect(@json[:data][:attributes]).to have_key(:name)
      expect(@json[:data][:attributes][:name]).to be_a(String)
      expect(@json[:data][:attributes]).to have_key(:street)
      expect(@json[:data][:attributes][:street]).to be_a(String)
      expect(@json[:data][:attributes]).to have_key(:city)
      expect(@json[:data][:attributes][:city]).to be_a(String)
      expect(@json[:data][:attributes]).to have_key(:county)
      expect(@json[:data][:attributes][:county]).to be_a(String)
      expect(@json[:data][:attributes]).to have_key(:state)
      expect(@json[:data][:attributes][:state]).to be_a(String)
      expect(@json[:data][:attributes]).to have_key(:zip)
      expect(@json[:data][:attributes][:zip]).to be_a(String)
      expect(@json[:data][:attributes]).to have_key(:lat)
      expect(@json[:data][:attributes][:lat]).to be_a(String)
      expect(@json[:data][:attributes]).to have_key(:lon)
      expect(@json[:data][:attributes][:lon]).to be_a(String)
      expect(@json[:data][:attributes]).to have_key(:vendor_count)
      expect(@json[:data][:attributes][:vendor_count]).to be_a(Integer)
    end

    it 'has market 404 error' do
      get '/api/v0/markets/0'

      data = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(404)
      expect(data[:errors]).to be_an(Array)
      expect(data[:errors].first[:detail]).to eq("Couldn't find Market with 'id'=0")
    end

    it 'returns all vendors for a market' do
      get "/api/v0/markets/#{@market1.id}/vendors"

      expect(response).to have_http_status(:success)

      data = JSON.parse(response.body, symbolize_names: true)

      data[:data][0] do |vendor|
        expect(vendor).to have_key(:id)
        expect(vendor[:id]).to be_a(String)
        expect(vendor[:id]).to eq(@vendor1.id.to_s)
        expect(vendor[:id]).to_not eq(@vendor2.id.to_s)
        expect(vendor[:id]).to_not eq(@vendor3.id.to_s)

        expect(vendor).to have_key(:type)
        expect(vendor[:type]).to eq('vendor')
        expect(vendor).to have_key(:attributes)
        expect(vendor[:attributes]).to be_a(Hash)
        expect(vendor[:attributes]).to have_key(:name)
        expect(vendor[:attributes][:name]).to be_a(String)
        expect(vendor[:attributes]).to have_key(:description)
        expect(vendor[:attributes][:description]).to be_a(String)
        expect(vendor[:attributes]).to have_key(:contact_name)
        expect(vendor[:attributes][:contact_name]).to be_a(String)
        expect(vendor[:attributes]).to have_key(:contact_phone)
        expect(vendor[:attributes][:contact_phone]).to be_a(String)
        expect(vendor[:attributes]).to have_key(:credit_accepted)
        expect(vendor[:attributes][:credit_accepted]).to be(true).or be(false)
      end
    end

    it 'has market 404 error for vendors path' do
      get '/api/v0/markets/0/vendors'

      data = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(404)
      expect(data[:errors]).to be_an(Array)
      expect(data[:errors].first[:detail]).to eq("Couldn't find Market with 'id'=0")
    end
  end
end
