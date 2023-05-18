# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'vendor requests', type: :request do
  describe 'vendor actions' do
    before :each do
      markets_and_vendors
      get "/api/v0/vendors/#{@vendor1.id}"
      @json = JSON.parse(response.body, symbolize_names: true)
    end

    describe 'specific vendor' do
      it 'has status code 200' do
        expect(response).to have_http_status(:success)
      end

      it 'shows vendor' do
        expect(@json[:data].length).to eq(3)
        expect(@json[:data][:attributes]).to have_key(:name)
        expect(@json[:data][:attributes][:name]).to be_a(String)
        expect(@json[:data][:attributes]).to have_key(:description)
        expect(@json[:data][:attributes][:description]).to be_a(String)
        expect(@json[:data][:attributes]).to have_key(:contact_name)
        expect(@json[:data][:attributes][:contact_name]).to be_a(String)
        expect(@json[:data][:attributes]).to have_key(:contact_phone)
        expect(@json[:data][:attributes][:contact_phone]).to be_a(String)
        expect(@json[:data][:attributes]).to have_key(:credit_accepted)
        expect(@json[:data][:attributes][:credit_accepted]).to be_in([true, false])
      end

      it 'has market 404 error' do
        get '/api/v0/vendors/0'

        data = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(404)
        expect(data[:errors]).to be_an(Array)
        expect(data[:errors].first[:detail]).to eq("Couldn't find Vendor with 'id'=0")
      end
    end

    describe 'create vendor' do
      it 'can create vendor' do
        post '/api/v0/vendors',
             params: { name: 'Supa Sella', description: 'Supa Sales!', contact_name: 'Supa Jones', contact_phone: '(911) 911-0911',
                       credit_accepted: true }

        expect(response.status).to eq(201)

        data = JSON.parse(response.body, symbolize_names: true)
        expect(data[:data][:type]).to eq('vendor')
        expect(data[:data][:attributes]).to eq({ name: 'Supa Sella',
                                                 description: 'Supa Sales!',
                                                 contact_name: 'Supa Jones',
                                                 contact_phone: '(911) 911-0911',
                                                 credit_accepted: true })
      end

      it 'can give 400 error' do
        post '/api/v0/vendors',
             params: { name: '', description: '', contact_name: 'Supa Jones', contact_phone: '(911) 911-0911',
                       credit_accepted: true }

        expect(response.status).to eq(400)

        data = JSON.parse(response.body, symbolize_names: true)
        expect(data[:errors][0][:detail]).to eq("Validation failed: Name can't be blank, Description can't be blank")
      end
    end

    describe 'update vendor' do
      it 'can update vendor' do
        patch "/api/v0/vendors/#{@vendor4.id}", params: { "contact_name": 'Kimberly Couwer', "credit_accepted": false }

        expect(response.status).to eq(200)
        expect(Vendor.last.contact_name).to eq('Kimberly Couwer')
        expect(Vendor.last.credit_accepted).to eq(false)
      end

      it 'can give 404 error' do
        patch '/api/v0/vendors/0', params: { "contact_name": 'Kimberly Couwer', "credit_accepted": false }

        data = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(404)
        expect(data[:errors][0][:detail]).to eq("Couldn't find Vendor with 'id'=0")
      end

      it 'can give 400 error' do
        patch "/api/v0/vendors/#{@vendor4.id}", params: { "name": '', "credit_accepted": false }

        data = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(400)
        expect(data[:errors][0][:detail]).to eq("Validation failed: Name can't be blank")
      end
    end

    describe 'delete vendor' do
      it 'can delete a vendor' do
        old_id = @vendor4.id
        delete "/api/v0/vendors/#{@vendor4.id}"

        expect(response.status).to eq(204)
        expect(Vendor.exists?(old_id)).to eq(false)
      end

      it 'can give 404 error' do
        delete '/api/v0/vendors/0'

        data = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(404)
        expect(data[:errors][0][:detail]).to eq("Couldn't find Vendor with 'id'=0")
      end
    end
  end
end
