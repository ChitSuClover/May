Rails.application.routes.draw do
  routes 'tasks#index'
  resources :tasks do
    resources :labels  
  end
end
