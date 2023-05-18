# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Vendor, type: :model do
  describe 'relationships' do
    it { should have_many(:market_vendors).dependent(:destroy) }
    it { should have_many(:markets).through(:market_vendors) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :contact_name }
    it { should validate_presence_of :contact_phone }
    it { should allow_value(%w[true false]).for(:credit_accepted) }
  end
end
