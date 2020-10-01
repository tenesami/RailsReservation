Rails.application.routes.draw do
  
  root 'sessions#home'

  
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

 
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create' 

 
  delete '/logout' => 'sessions#destroy'

  
get "/auth/:provider/callback" => 'sessions#google'
#get 'auth/google_oauth2/callback', to: 'sessions#google'

  
  resources :restaurants  do
    resources :reservations 
  end
  
  resources :reservations 
  
  resources :users do
    resources :restaurants, shallow: true
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
