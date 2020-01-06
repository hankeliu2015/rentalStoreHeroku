Rails.application.routes.draw do
  get 'store_admin/dashboard'
  #get 'users/show'
   devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
   # set route for confirm email after register
   # resource :users do
   #   member do
   #     get :confirm_email
   #   end
   # end
  # resources :users, only: [:show]
  # devise_for :users

  root 'tools#index'

  resources :tools do
    resources :rentals, only: [:new, :create, :update, :edit, :show] do
      member do
        patch :reschedule_return
      end
    end
  end

  post 'rentals', to: 'rentals#create'
  post 'rentals/discount', to: 'rentals#create_discount_rental'
  get 'rentals/new'
  get 'profile', to: 'users#show'
  get 'profile/monthly', to: 'users#user_monthly_report'
  get 'rentals', to: 'rentals#index'

  # resources :users, only: [:show] do
  #   resources :rentals, only: [:index]
  # end

  # moved the following route to tools/rentals nested routes.
  # patch 'rentals/:id', to: 'rentals#reschedule_return', as: 'reschedule_return'

  patch 'rentals/:id/checkout_update', to: 'rentals#checkout_update', as: 'checkout'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
