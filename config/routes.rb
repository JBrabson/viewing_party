Rails.application.routes.draw do
  root 'welcome#index'
  
  get '/registration', to: 'sessions#new'
end
