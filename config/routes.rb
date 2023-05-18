# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      resources :vendors, only: %i[show create update destroy]
      resources :markets, only: %i[index show] do
        resources :vendors, only: [:index]
      end
      resources :market_vendors, only: [:create]
      delete '/market_vendors', to: 'market_vendors#destroy'
    end
  end
end
