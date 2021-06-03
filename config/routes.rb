Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  resources :labels
  get '/search', to: 'tasks#search'
end
