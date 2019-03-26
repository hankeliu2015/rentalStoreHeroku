Rails.application.routes.draw do

  devise_for :users
  root 'tools#index'

  get 'tools/index'
  get 'tools/show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
