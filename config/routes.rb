Rails.application.routes.draw do
  # devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }

  devise_for :users
  root 'tools#index'

  get 'rentals/new'

  # get 'tools/index'
  # get 'tools/show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
