# frozen_string_literal: true

module Api
  module V0
    class MarketVendorsController < ApplicationController
      def create
        @market_vendor = MarketVendor.new(market_vendor_params)
        if @market_vendor.save
          render json: { "message": 'Successfully added vendor to market' }, status: 201
        elsif MarketVendor.exists?(vendor_id: market_vendor_params[:vendor_id].to_s,
                                   market_id: market_vendor_params[:market_id].to_s)
          render json: ErrorMessageSerializer.serialize("Validation failed: Market vendor asociation between market with market_id=#{market_vendor_params[:market_id]} and vendor_id=#{market_vendor_params[:vendor_id]} already exists"),
                 status: 422
        elsif Market.exists?(market_vendor_params[:market_id])
          render json: ErrorMessageSerializer.serialize('Validation failed: Vendor must exist'), status: 404
        else
          render json: ErrorMessageSerializer.serialize('Validation failed: Market must exist'), status: 404
        end
      end

      def destroy
        market_vendor = MarketVendor.find_by(market_vendor_params)
        if !market_vendor.nil?
          market_vendor.destroy
        else
          render json: ErrorMessageSerializer.serialize("Validation failed: No MarketVendor with market_id=#{market_vendor_params[:market_id]} AND vendor_id=#{market_vendor_params[:vendor_id]} exists"),
                 status: 404
        end
      end

      private

      def market_vendor_params
        params.permit(:market_id, :vendor_id)
      end
    end
  end
end
