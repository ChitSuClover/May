Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks do
    resources :labels
  end
end
