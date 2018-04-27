Rails.application.routes.draw do
  root to: 'home#index'

  namespace :api do
    namespace :v1 do
      resources :ships, only: [:index, :create, :update]
    end
  end
end
