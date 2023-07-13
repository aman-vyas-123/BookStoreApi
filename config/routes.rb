Rails.application.routes.draw do
  root 'books#index'

  resources :users, param: :_username
  post '/auth/login', to: 'authentication#login'
  #get '/*a', to: 'application#not_found'
  
  get '/books', to: 'books#index'
  get '/books/:id', to: 'books#show'
  post '/books', to: 'books#create'
  patch '/books/:id', to: 'books#update'
  delete '/books/:id', to: 'books#destroy'

  post '/', to: 'books#create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
