# frozen_string_literal: true

class MarketVendor < ApplicationRecord
  validates_presence_of :market_id
  validates_presence_of :vendor_id
  validate :unique_combination, on: :create

  belongs_to :market
  belongs_to :vendor

  def unique_combination
    return unless MarketVendor.exists?(vendor_id: vendor_id.to_s, market_id: market_id.to_s)

    errors.add(:base,
               "Market vendor association between market with market_id=#{market_id} and vendor_id=#{vendor_id} already exists")
  end
end
