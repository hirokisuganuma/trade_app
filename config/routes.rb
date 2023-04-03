Rails.application.routes.draw do
  root 'value_high_rankings#index'
  resources :year_to_date_highs, only: [:index]
  resources :financial_companies, only: [:index]
end
