Rails.application.routes.draw do
  root to: 'home#index'
  resources :orders do
    post :confirm, action: :confirm_new, on: :new 
    collection do
      get 'complete'
    end
  end
  resources :products
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"
  get 'search', to: "products#search"
  resources :users do
    patch :confirm, action: :confirm_edit
  end
  get '/users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
  patch '/users/:id/withdrawal' => 'users#withdrawal', as: 'withdrawal'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
