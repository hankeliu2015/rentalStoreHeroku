Rails.application.routes.draw do
  #get 'users/show'
   devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  # resources :users, only: [:show]
  # devise_for :users

  root 'tools#index'

  resources :tools do
    resources :rentals, only: [:new, :create, :update, :edit, :show]
  end

  get 'rentals/new'

  resources :users, only: [:show] do
    resources :rentals, only: [:index]
  end

  patch 'rentals/:id', to: 'rentals#reschedule_return', as: 'reschedule_return'

  patch 'rentals/:id/checkout_update', to: 'rentals#checkout_update', as: 'checkout'

  # resources :rentals do
  #   member do
  #     patch :checkout_update
  #   end
  # end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
