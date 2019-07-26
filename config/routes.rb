Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post 'login', to: 'login#login'
  post 'register', to: 'register#register'
  get  'profile', to: 'profile#show'

  get  'products', to: 'product#index'
  get  'products/:id', to: 'product#show'

  post 'transactions', to: 'transaction#store'
  post 'transactions/:id/cancel', to: 'transaction#cancel'
end
