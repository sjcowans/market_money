# frozen_string_literal: true

module Api
  module V0
    class VendorsController < ApplicationController
      def index
        @market = Market.find(params[:market_id])
        render json: VendorSerializer.new(@market.vendors)
      end

      def show
        @vendor = Vendor.find(params[:id])
        render json: VendorSerializer.new(@vendor)
      end

      def create
        vendor = Vendor.create!(vendor_params)
        render json: VendorSerializer.new(vendor), status: 201
      end

      def destroy
        render json: Vendor.destroy(params[:id]), status: 204
      end

      def update
        vendor = Vendor.find(params[:id])
        vendor.update!(vendor_params)
        render json: VendorSerializer.new(vendor)
      end

      private

      def vendor_params
        params.permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
      end
    end
  end
end
