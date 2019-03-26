Rails.application.routes.draw do

  root 'tools#index'

  get 'tools/index'
  get 'tools/show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
