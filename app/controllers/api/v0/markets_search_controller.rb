module Api
  module V0
    class MarketsSearchController < ApplicationController
      def index
        @markets = Market.search(search_params.compact)
        if @markets == "invalid"
          render json: ErrorMessageSerializer.serialize("Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint."), status: 422
        else
          render json: MarketSerializer.new(@markets)
        end
      end

      private

      def search_params
        params.permit(:state, :city, :name, :markets_search)
      end
    end
  end
end