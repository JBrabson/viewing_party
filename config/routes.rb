Rails.application.routes.draw do
  root 'welcome#index'
  get 'registration', to: 'sessions#new'
  post '/', to: 'sessions#new'
  get '/dashboard', to: 'dashboard#index'
end
