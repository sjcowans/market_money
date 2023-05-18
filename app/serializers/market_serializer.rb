# frozen_string_literal: true

class MarketSerializer
  include JSONAPI::Serializer
  attributes :name, :street, :city, :county, :state, :zip, :lat, :lon

  attribute :vendor_count do |market|
    market.vendors.count
  end
end
