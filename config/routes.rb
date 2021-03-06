Rails.application.routes.draw do

  get 'welcome/about'
  root to: 'welcome#index'

  namespace :api, defaults: { format: :json } do
    resources :users do
      resources :lists
    end

    resources :lists, only: [] do
      resources :items, only: [:create, :index]
    end

    resources :items, only: [:destroy, :update]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
