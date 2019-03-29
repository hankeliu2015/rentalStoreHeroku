Rails.application.routes.draw do
  #get 'users/show'
   devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }

   resources :users, only: [:show]
  # devise_for :users
  root 'tools#index'

  # resources :rentals, only: [:new, :create, :update]
  # get 'rent/tool/:tool_id', to: 'rentals#new', as: 'new_rental'
  # post 'rent', to: 'rentals#create', as: 'rentals'
  # patch 'rent/tool/:tool_id', to: 'rentals#update', as: 'rental'

  resources :tools do
    resources :rentals, only: [:new, :create, :update, :edit]
  end


  #resources :users, only: [:show]

  # get 'rentals/new'

  # get 'tools/index'
  # get 'tools/show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
