Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  resources :labels
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :edit, :show, :index, :update]
  get '/search', to: 'tasks#search'
end
