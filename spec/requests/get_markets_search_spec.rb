# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'markets search', type: :request do
  describe 'search markets' do
    before :each do
      markets_and_vendors
    end

    it 'can search for market by state' do
      get '/api/v0/markets/search', params: {state: "New South Wales" }

      expect(response.status).to eq(200)
    end
  end
end