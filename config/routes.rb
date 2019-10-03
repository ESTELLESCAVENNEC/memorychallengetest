Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'payments', to: 'payments#index'
  get 'payments/new', to: 'payments#new'
  post 'payments', to: 'payments#create'
  get 'payments/:id', to: 'payments#show'
end


