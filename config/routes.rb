Rails.application.routes.draw do
  get 'tools/index'
  get 'tools/show'
  root 'tools#index'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
