Rails.application.routes.draw do
  namespace :api do
    resources :events, only: [:index]
  end

  get 'oauth', to: 'api/oauth#index'
  get 'oauth/callback', to: 'api/oauth#callback'
end
