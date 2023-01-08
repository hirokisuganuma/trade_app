# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # TODO: indexへ変更予定
  root 'trading_value_high_rankings#show'
  resources :year_to_date_highs, only: [:index]
end
