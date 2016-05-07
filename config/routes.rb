Rails.application.routes.draw do
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'home#index'

  resources :events, only: [:index] do
    collection do
      get 'add'
    end
  end

  namespace :api do
    resources :events, only: [:index]
    resources :crawlers, only: [:index]
  end

  get 'oauth', to: 'api/oauth#index'
  get 'oauth/callback', to: 'api/oauth#callback'
end
