Rails.application.routes.draw do
  root 'welcome#index'
  get '/registration', to: 'users#new'
  post '/registration', to: 'users#create'
  post '/', to: 'sessions#new'
  get '/dashboard', to: 'dashboard#index'
  get '/discover', to: 'discover#index'
  post '/friendships', to: 'friendships#create'
  get '/movies/index', to: 'movies#index'
  get '/movies/:id', to: 'movies#show'
  get '/parties/new', to: 'parties#new'
end
