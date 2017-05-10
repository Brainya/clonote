Rails.application.routes.draw do
  devise_for :users
  root 'notes#index'
  resources :notes
  resources :users, only: :show
end
