module Api
  module V0
    class NearestAtmsController < ApplicationController
      def index
        @market = Market.find(params[:market_id])
        @atms = SearchFacade.new(@market).atm_search
        render json: AtmSerializer.new(@atms)
      end
    end
  end
end