Rails.application.routes.draw do
  #get 'users/show'
   devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }

   # resources :users, only: [:show]
  # devise_for :users
  root 'tools#index'

  # resources :rentals, only: [:new, :create, :update]
  # get 'rent/tool/:tool_id', to: 'rentals#new', as: 'new_rental'
  # post 'rent', to: 'rentals#create', as: 'rentals'
  # patch 'rent/tool/:tool_id', to: 'rentals#update', as: 'rental'

  resources :tools do
    resources :rentals, only: [:new, :create, :update, :edit, :show]
  end

  get 'rentals/new'

  resources :users, only: [:show] do
    resources :rentals, only: [:index]
  end

  patch 'rentals/:id', to: 'rentals#reschedule_return', as: 'reschedule_return'

  patch 'rentals/:id', to: 'rentals#checkout_update', as: 'checkout'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
